# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('#edit-answer-' + answer_id).fadeIn();

  $('form.new_answer').bind 'ajax:success', (e) ->
    answer = $.parseJSON(e.detail[2].responseText)
    $('.answers').append answer.body
  .bind 'ajax:error', (e) ->
    errors = $.parseJSON(e.detail[2].responseText)
    $.each errors, (index, value) ->
      $('.errors').html(value)

$(document).ready(ready)
$(document).on('turbolinks:load', ready)