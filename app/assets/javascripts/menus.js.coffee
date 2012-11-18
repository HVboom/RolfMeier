# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  update_menu = (event, ui) ->
    menu_item = ui.item.get(0)
    menu_item_parent = menu_item.parentElement
    parent = event.target
    # ignore event on the "old" menu, when moving to another menu
    if(menu_item_parent isnt parent)
      return true
    else
      menu_item_id = menu_item.id.split("_").pop()
      # detect sort of root menu item by assignment of 0 to parent_id
      parent_id = + parent.id.split("_").pop() || 0
      add_before_menu_item = menu_item.nextSibling
      # skip over dummy li element inserted to enable drop on empty menus
      while(add_before_menu_item && !add_before_menu_item.id)
        add_before_menu_item = add_before_menu_item.nextSibling

      position_id = 0
      # check, if the position is not the last one in the submenu
      if(add_before_menu_item)
        position_id = add_before_menu_item.id.split("_").pop()

      # menu_item_id is submitted as part of the url
      data =
        parent_id: "#{parent_id}"
        position_id: "#{position_id}"

      url = menu_item.dataset.updateUrl
      $.post(url, data)

  $("#menus.sortable").sortable(
    items: "> li"
    axis: "x"
    placeholder: "ui-state-highlight"
    cursor: 'move'
    # handle: ".handle"
    update: (event, ui) ->
      update_menu(event, ui)
  )

  $('.submenus_menu.sortable').sortable(
    items: "> li"
    connectWith: "ul"
    dropOnEmpty: true
    placeholder: "ui-state-highlight"
    cursor: 'move'
    # handle: ".handle"
    update: (event, ui) ->
      update_menu(event, ui)
  )

  $('.sortable').disableSelection()

