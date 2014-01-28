# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  # Handling ajax responses for adding a serving.
  $("#new_serving").on("ajax:success", (e, data, status, xhr) ->
    $("#servings_list").append xhr.responseText
    $("#new_serving")[0].reset()
  ).bind "ajax:error", (e, xhr, status, error) ->
    alert("Error: Couldn't add, sorry! Try again later.");

  # Clicked on the context menu.
  $("#contextMenu").on("click", "a", (event) ->
    chose = $(this).attr('id')
    if chose == 'context_delete'
      window.servingClicked.remove()
      delete window.servingClicked
    else
      message = "selected the menu item '" + chose + "'"
      alert(message);

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

    event.stopPropagation();  
    return false;

  # Somewhere besides the context menu is clicked, so hide it.
  $(document).click ->
    $("#contextMenu").hide();


