# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#new_document').fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(pdf)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file).trim())
        $('#progressbars').append(data.context)
        data.submit()
      else
        alert("#{file.name} is not a pdf file")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      if data.context
        data.context.fadeOut('slow', -> data.context.remove())
