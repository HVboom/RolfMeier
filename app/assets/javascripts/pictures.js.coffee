# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#new_picture').fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file).trim())
        $('#progressbars').append(data.context)
        data.submit()
      else
        alert("#{file.name} is not a gif, jpeg, or png image file")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      if data.context
        data.context.fadeOut('slow', -> data.context.remove())

  new PictureCropper()

class PictureCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 200 / 150
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#picture_crop_x').val(coords.x)
    $('#picture_crop_y').val(coords.y)
    $('#picture_crop_w').val(coords.w)
    $('#picture_crop_h').val(coords.h)



