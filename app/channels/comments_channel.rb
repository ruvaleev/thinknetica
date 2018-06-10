class CommentsChannel < ApplicationCable::Channel
  def follow(data)
    stream_from "comments_for_#{data['question_id']}"
  end
end