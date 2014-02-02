# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# For the basis of the context menu, see: http://jsfiddle.net/KyleMit/X9tgY/

$(document).ready ->
  # Handling ajax response for adding a serving.
  $("#new_serving").on("ajax:success", (e, data, status, xhr) ->
    $("#servings_list").append xhr.responseText
    $("#new_serving")[0].reset()
  ).bind "ajax:error", (e, xhr, status, error) ->
    alert("Error: Couldn't add, sorry! Try again later.");

  # Handling ajax response for deleting a serving.
  $("#delete_serving").on("ajax:success", (e, data, status, xhr) ->
    serving = $('#serving'+data.id.toString());

    serving.fadeOut("slow", ->
      $(this).remove();
    )
  ).bind "ajax:error", (e, xhr, status, error) ->
    alert("Error deleting!");

  # Handling ajax response for editing a serving.
  $("#update_serving").on("ajax:success", (e, data, status, xhr) ->
    window.servingClicked.replaceWith(data.html)    
    window.servingClicked = null
    element = $('#serving'+window.servingClickedId.toString());
    console.log(element);
    element.fadeTo(400.0, 0.0).fadeTo(400.0, 1.0);
  ).bind "ajax:error", (e, xhr, status, error) ->
    alert("error!");

  # Handling ajax response for moving up a serving.
  $("#move_up").on("ajax:success", (e, data, status, xhr) ->
    serving = $('#serving'+data.id.toString());
    serving2 = serving.prev();
    serving.insertBefore(serving2);
    serving.fadeTo(200.0, 0.0).fadeTo(200.0, 1.0);
  ).bind "ajax:error", (e, xhr, status, error) ->
    alert("Error moving up!");

  # Handling ajax response for moving up a serving.
  $("#move_down").on("ajax:success", (e, data, status, xhr) ->
    serving = $('#serving'+data.id.toString());
    serving2 = serving.next();
    serving.insertAfter(serving2);
    serving.fadeTo(200.0, 0.0).fadeTo(200.0, 1.0);
  ).bind "ajax:error", (e, xhr, status, error) ->
    alert("Error moving up!");
  
  # Clicked on the context menu.
  $("#contextMenu").on("click", "a", (event) ->
    # Submit the proper AJAX form to perform the action we want.
    chose = $(this).attr('id')
    if chose == 'context_delete'
      $('#delete_serving').find("#id").val(window.servingClickedId);
      $('#delete_serving').submit();
    else if chose == 'context_up'
      $('#move_up').find("#id").val(window.servingClickedId);
      $('#move_up').submit();
    else if chose == 'context_down'
      $('#move_down').find("#id").val(window.servingClickedId);
      $('#move_down').submit();
    else if chose == 'context_edit'
      # Pull out the values we stored off in data- attributes for just this purpose!
      $('#update_serving').find("#id").val( window.servingClickedId );
      $('#update_serving').find("#quantity").val( window.servingClicked.attr('data-quantity') );
      $('#update_serving').find("#name").val( window.servingClicked.attr('data-name') );
      $('#update_serving').find("#calories").val( window.servingClicked.attr('data-calories') );
      $("#update_modal").modal('show');
      $('#update_modal').on('shown.bs.modal', ->
        $('#update_serving').find("#quantity").focus();
        $('#update_serving').find("#quantity").select();
      )

    window.close_context_menu(event);
    return false;
  )

  # On edit form submit, close modal (and still submit).
  $('#update_serving_submit').on("click", (event) ->
    $("#update_modal").modal('hide');
    return true;
  )

  window.close_context_menu = (e) ->
    $("#contextMenu").css({
      display: "none"
    });
    return false;

  window.open_context_menu = (e, servingClicked) ->
    contextMenu = $("#contextMenu");
    contextMenu.css({
      display: "block",
      left: e.pageX,
      top: e.pageY
    });

    # Remember who was clicked to open context menu.
    window.servingClicked = $(servingClicked)
    window.servingClickedId = $(servingClicked).attr('data-id')

    event.stopPropagation();  
    return false;

  # Somewhere besides the context menu is clicked, so hide it.
  $(document).click ->
    $("#contextMenu").hide();


