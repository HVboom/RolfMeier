# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  update_gallery = (event, ui) ->
    picture = ui.item.get(0)
    gallery = picture.parentElement
    current_gallery = event.target
    # ignore event on the "old" gallery, when moving to another gallery
    if(gallery isnt current_gallery)
      return true
    else
      picture_id = picture.id.split("_").pop()
      gallery_id = gallery.id.split("_").pop()
      add_before_picture = picture.nextSibling
      # skip over dummy li element inserted to enable drop on empty galleries
      while(add_before_picture && !add_before_picture.id)
        add_before_picture = add_before_picture.nextSibling

      position_id = 0
      # check, if the position is not the last one in the gallery
      if(add_before_picture)
        position_id = add_before_picture.id.split("_").pop()

      # picture_id is submitted as part of the url
      data =
        gallery_id: "#{gallery_id}"
        position_id: "#{position_id}"

      url = picture.dataset.updateUrl
      $.post(url, data)

  $('.sortable').sortable(
    items: "> li"
    connectWith: "ul"
    dropOnEmpty: true
    placeholder: "ui-state-highlight"
    cursor: "move"
    # handle: ".handle"
    update: (event, ui) ->
      update_gallery(event, ui)
  )

  $('.sortable').disableSelection()


