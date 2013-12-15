# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require gmaps4rails/gmaps4rails.base
#= require gmaps4rails/gmaps4rails.googlemaps
#= require jquery
#= require jquery.ui.widget
#= require jquery.ui.rlightbox
#= require bootstrap
#= require bootstrapx-clickover
#= require rails.validations
#= require rails.validations.simple_form
#= require jquery.eqheight

jQuery ->
  # same height for left and right content
  $('#main').eqHeight('article, aside')


  # slide show
  $('.lb_gallery').rlightbox
    keys: {next: [78, 39], previous: [80, 37], close: [67, 27], panorama: [null]}
    loop: true

  slide_show = ->
    if $('#slide_show_1').is(':hidden')
      if $('#slide_show_2').is(':hidden')
        '#slide_show_3'
      else
        '#slide_show_2'
    else
      '#slide_show_1'

  # $(slide_show).carousel
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
