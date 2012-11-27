# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require jquery
#= require jquery.ui.widget
#= require jquery.ui.rlightbox
#= require jquery.ui.rcarousel

jQuery ->
  $('.lb_gallery').rlightbox({
    keys: {next: [78, 39], previous: [80, 37], close: [67, 27], panorama: [null]}
    loop: true
  })

  $('.slide_show>div').rcarousel({
    auto:    {enabled: true}
    width:   200
    height:  150
    margin:  40
    visible: 2
    step:    2
  })

