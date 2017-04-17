# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  return unless $('#home-view').length

  countUp = $('#homeProjectCountUp')
  countUpAnimation = new CountUp(countUp.attr('id'), 0, countUp.text(), 0, 2.5)

  applyCountUp = ->
    topLimit = $(window).scrollTop() + $(window).height()
    return unless countUp.offset().top < topLimit
    countUpAnimation.start()

  $(window).on 'scroll', applyCountUp
  applyCountUp()
