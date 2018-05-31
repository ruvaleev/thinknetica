class AnswersChannel < ApplicationCable::Channel
  def follow(question_id)
    stream_from 'answers'
  end
end