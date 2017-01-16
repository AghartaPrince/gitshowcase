class User < ApplicationRecord
  SOCIALS = %w(angellist twitter linkedin facebook medium stack_overflow blog).freeze

  has_many :projects

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  def socials
    result = {}
    result['github'] = "https://github.com/#{self.username}"

    User::SOCIALS.each do |social|
      result[social] = self[social] unless self[social].to_s.empty?
    end

    result
  end

  def self.from_omniauth(auth)
    user = where(github_uid: auth.uid).first

    if user
      user.github_token = auth.credentials.token
      user.save
    else
      user = User.new
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.github_uid = auth.uid
      user.github_token = auth.credentials.token
      user.role = 'Jedi Developer'

      user.sync
    end

    user
  end

  def sync
    sync_profile
    sync_skills_projects
  end

  def sync_profile
    user = client.user

    self.avatar = user.avatar_url
    self.username = user.login.to_s.downcase
    self.name = user.name
    self.website = user.blog if user.blog.present?
    self.location = user.location if user.location.present?
    self.email = user.email
    self.hireable = user.hireable
    self.bio = user.bio if user.bio.present?

    self.company = user.company
    self.company_website = 'https://github.com/' + self.company[1..-1] if self.company.present? and self.company[0] == '@'

    save!
  end

  def sync_skills_projects
    result = []

    client.repositories.each do |repository|
      project = projects.where(repository: repository.full_name).first

      unless project
        project = projects.new(repository: repository.full_name)
        project.sync(repository)

        result.push project

        if project.language.present?
          self.skills = {} unless self.skills
          self.skills[project.language] = 3 unless self.skills[project.language]
        end
      end
    end

    save!

    result
  end

  private

  def client
    @client ||= Octokit::Client.new(:access_token => self.github_token)
  end
end
