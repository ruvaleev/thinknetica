# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('#edit-answer-' + answer_id).fadeIn();

# Скрываем лучший ответ из общего списка ответов
  data = $('#best .edit-answer-link').data('answerId');
  $(".answers #tr#{data}").hide();

$(document).ready(ready)
$(document).on('turbolinks:load', ready)