# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require jquery
#= require jquery_ujs
#= require jquery.ui.widget
#= require jquery.ui.rlightbox
#= require bootstrap
#= require bootstrapx-clickover
#= require rails.validations
#= require rails.validations.simple_form
#= require jquery.eqheight
#= require underscore
#= require gmaps/google

jQuery ->
  # same height for left and right content
  $('#main').eqHeight('article, aside')


  # slide show
  $('.lb_gallery_1').rlightbox
    keys: {next: [78, 39], previous: [80, 37], close: [67, 27], panorama: [null]}
    loop: true

  $('.lb_gallery_2').rlightbox
    keys: {next: [78, 39], previous: [80, 37], close: [67, 27], panorama: [null]}
    loop: true

  $('.lb_gallery_3').rlightbox
    keys: {next: [78, 39], previous: [80, 37], close: [67, 27], panorama: [null]}
    loop: true

  slide_show = ->
    if $('#slide_show_1').is(':visible')
      '#slide_show_1'
    else
      if $('#slide_show_2').is(':visible')
        '#slide_show_2'
      else
        '#slide_show_3'

  # alert('#slides_1 visible? ' + $('#slides_1').is(':visible'))
  # alert('#slides_2 visible? ' + $('#slides_2').is(':visible'))
  # alert('#slides_3 visible? ' + $('#slides_3').is(':visible'))

  # alert('#slides_1 hidden? ' + $('#slides_1').is(':hidden'))
  # alert('#slides_2 hidden? ' + $('#slides_2').is(':hidden'))
  # alert('#slides_3 hidden? ' + $('#slides_3').is(':hidden'))

  # alert('#slide_show_1 visible? ' + $('#slide_show_1').is(':visible'))
  # alert('#slide_show_2 visible? ' + $('#slide_show_2').is(':visible'))
  # alert('#slide_show_3 visible? ' + $('#slide_show_3').is(':visible'))

  # alert('#slide_show_1 hidden? ' + $('#slide_show_1').is(':hidden'))
  # alert('#slide_show_2 hidden? ' + $('#slide_show_2').is(':hidden'))
  # alert('#slide_show_3 hidden? ' + $('#slide_show_3').is(':hidden'))

  # alert(slide_show())

  # $(slide_show()).carousel
  $('.carousel').carousel
    cycle:    'cycle'
    interval: 4000
    pause:    'hover'


  # navigation
  $('.dropdown-toggle').dropdown()

  $('ul.nav li.dropdown').hover(
    ->
      $(this).closest('.dropdown-menu').stop(true, true).delay(500).fadeIn()
      $(this).addClass 'open'
    ->
      $(this).closest('.dropdown-menu').stop(true, true).delay(500).fadeOut()
      $(this).removeClass 'open'
  )


  # add an indicator for external links and force the link to open in a new window
  $('a').filter(
    ->
     @hostname and @hostname isnt location.hostname
  ).addClass('external').attr('target', '_blank')


  # clickover
  $('[rel=clickover]').clickover
    placement: 'left'
    html:      true
    animation: true
    esc_close: false
