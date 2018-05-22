ready = ->

  $('.rating').bind 'ajax:success', (e) ->
    vote = $.parseJSON(e.detail[2].responseText)
    $("#tr#{vote.vote.object_id} .rating").hide()
    $("#tr#{vote.vote.object_id} .rating .point").html(vote.rating)
    $("#tr#{vote.vote.object_id} .rating").fadeIn()
  $('.plus-minus').click (e) ->
    $(this).toggleClass('disactive')
      

$(document).on('turbolinks:load', ready)