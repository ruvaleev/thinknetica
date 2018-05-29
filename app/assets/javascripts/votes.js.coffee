ready = ->

  $('.rating').bind 'ajax:success', (e) ->
    vote_id = e.detail[0].vote.object_id
    rating = e.detail[0].rating
    console.log(vote_id)
    console.log(rating)
    $("#tr#{vote_id} .rating").hide()
    $("#tr#{vote_id} .rating .point").html(rating)
    $("#tr#{vote_id} .rating").fadeIn()
  $('.plus-minus').click (e) ->
    $(this).toggleClass('disactive')
      

$(document).on('turbolinks:load', ready)