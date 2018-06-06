class AnswersChannel < ApplicationCable::Channel
  def follow(data)
    logger.debug "в канал пришло #{data}"
    logger.debug "data question id в канал пришло #{data['question_id']}"
    stream_from "answers_#{data['question_id']}"
  end
end