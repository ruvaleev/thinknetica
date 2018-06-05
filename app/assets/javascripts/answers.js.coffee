# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('#edit-answer-' + answer_id).fadeIn();

  $('.comment-answer-link').click (e) ->
    e.preventDefault();
    answer_id = $(this).data('answerId');
    $('#comment-answer-' + answer_id).fadeIn();

  App.cable.subscriptions.create('AnswersChannel', {
    connected: ->
      console.log 'Connected!'
      console.log(gon.question)
      console.log(gon.current_user.id)
      @perform 'follow'  
    ,

    received: (data) ->
      console.log(data)
      answer = JSON.parse(data)
      console.log(answer)
      console.log('куррент юзер' + gon.current_user.id)
      unless @userIsCurrentUser(answer.user_id)
        $('.answers').append(JST['answer'](
          answer: answer,
          current_user: gon.current_user,
          question: gon.question
          )) 

    userIsCurrentUser: (user_id) ->
      user_id is gon.current_user.id    
  })

$(document).on('turbolinks:load', ready)