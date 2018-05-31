# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('#edit-answer-' + answer_id).fadeIn();

  App.cable.subscriptions.create('AnswersChannel', {
    connected: ->
      console.log 'Connected!'
      @perform 'follow'
    ,

    received: (data) ->
      $('.answers').append data
  })

$(document).on('turbolinks:load', ready)