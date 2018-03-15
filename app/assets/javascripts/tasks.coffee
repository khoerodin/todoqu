# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  window.due = () ->
    $.ajax '/due',
      type: 'GET'
      dataType: 'html'
      success: (data, textStatus, jqXHR) ->
        $('#due').html(data);
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
    
  window.all = () ->
    $.ajax '/all',
      type: 'GET'
      dataType: 'html'
      success: (data, textStatus, jqXHR) ->
        $('#all').html(data);
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus

  $(document).on('change', '#sortedBy', ( ->
    $.ajax '/sorting',
      type: 'POST'
      dataType: 'html'
      data: { sorted_by: this.value }
      success: (data, textStatus, jqXHR) ->
        $('#all').html(data)
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
  ))
  
  $(document).on('change', '[name="task-check"][type="checkbox"]', ( ->
    $.ajax '/update/'+ $(this).attr('id'),
      type: 'PUT'
      dataType: 'html'
      data: { completed: $(this).is(':checked') }
      success: (data, textStatus, jqXHR) ->
        due() all()
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
  ))
