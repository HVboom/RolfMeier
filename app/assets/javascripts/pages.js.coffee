# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require gmaps4rails/gmaps4rails.base
#= require gmaps4rails/gmaps4rails.googlemaps
#= require jquery
#= require jquery.ui.widget
#= require jquery.ui.rlightbox
#= require bootstrap
#= require rails.validations
#= require rails.validations.simple_form
#= require jquery.eqheight

jQuery ->
  $('.lb_gallery').rlightbox
    keys: {next: [78, 39], previous: [80, 37], close: [67, 27], panorama: [null]}
    loop: true

  $('.carousel').carousel
    cycle:    'cycle'
    interval: 4000
    pause:    'hover'

  $('[rel=popover]').popover
    placement: 'left'
    html:      true
    trigger:   'hover'

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
  
  $('#main').eqHeight('article, aside')
