# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#new_serving").on("ajax:success", (e, data, status, xhr) ->
    $("#servings_list").append xhr.responseText
    $("#new_serving")[0].reset()
  ).bind "ajax:error", (e, xhr, status, error) ->
    alert("Error: Couldn't add, sorry! Try again later.");