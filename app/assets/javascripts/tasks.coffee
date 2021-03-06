# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:before-cache', ->
    $('select.form-control').select2({theme: "bootstrap"})

$(document).on 'turbolinks:load', ->
  $('select.form-control').select2({theme: "bootstrap"})

$(document).on 'ready', ->  

  window.due = () ->
    $.ajax '/due',
      type: 'GET'
      dataType: 'html'
      success: (data, textStatus, jqXHR) ->
        $('#due').html(data);
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
    
  window.all = () ->
    $.ajax '/filter',
      type: 'POST'
      dataType: 'html'
      data: { filter: $('#filter').val(), sort: $('#sort').val() }
      success: (data, textStatus, jqXHR) ->
        $('#tasks').html(data)
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus

  $(document).on('change', '#filter, #sort', ( ->
    $.ajax '/filter',
      type: 'POST'
      dataType: 'html'
      data: { filter: $('#filter').val(), sort: $('#sort').val() }
      success: (data, textStatus, jqXHR) ->
        $('#tasks').html(data)
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
  ))
  
  $(document).on('change', '[name="task-check"][type="checkbox"]', ( ->
    $.ajax '/update/'+ $(this).attr('id'),
      type: 'PUT'
      dataType: 'html'
      data: { 'task[completed]': $(this).is(':checked') }
      success: (data, textStatus, jqXHR) ->
        due() 
        all()
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
  ))
