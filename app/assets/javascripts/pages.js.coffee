# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require gmaps4rails/gmaps4rails.base
#= require gmaps4rails/gmaps4rails.googlemaps
#= require jquery
#= require jquery.ui.widget
#= require jquery.ui.rlightbox
#= require jquery.ui.rcarousel
#= require bootstrap
#= require jquery.eqheight

jQuery ->
  $('.lb_gallery').rlightbox({
    keys: {next: [78, 39], previous: [80, 37], close: [67, 27], panorama: [null]}
    loop: true
  })

  $('.carousel').carousel({
    cycle:    'cycle'
    interval: 4000
    pause:    'hover'
  })

  $('[rel=popover]').popover({
    placement: 'left'
    html:      true
    trigger:   'hover'
  })

  $('.dropdown-toggle').dropdown()

  $('#main').eqHeight("article, aside")
