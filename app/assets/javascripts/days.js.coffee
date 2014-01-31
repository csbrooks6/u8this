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
    $(serving).remove();
    # TODO: Fading would be neat:
    #serving.fadeOut("slow", ->
    #  $(this).remove();
    #)
    # It works, but as it fades the menu item remains clickable. 
    # No obvious answer, and I don't want to fool with it right now, so just remove.
  ).bind "ajax:error", (e, xhr, status, error) ->
    alert("Error deleting!");

  # Handling ajax response for moving up a serving.
  $("#move_up").on("ajax:success", (e, data, status, xhr) ->
    serving = $('#serving'+data.id.toString());
    serving.insertBefore(serving.prev());    
  ).bind "ajax:error", (e, xhr, status, error) ->
    alert("Error moving up!");

  # Handling ajax response for moving up a serving.
  $("#move_down").on("ajax:success", (e, data, status, xhr) ->
    serving = $('#serving'+data.id.toString());
    serving.insertAfter(serving.next());    
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
      # TODO: Show modal dialog!
      x=1

    window.close_context_menu(event);
    return false;
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
    window.servingClickedId = $(servingClicked).attr('id').replace('serving', '')

    event.stopPropagation();  
    return false;

  # Somewhere besides the context menu is clicked, so hide it.
  $(document).click ->
    $("#contextMenu").hide();


