class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer = Answer.find(params[:answer_id])
    @question = Question.find(@answer.question_id)
    if current_user.author_of?(@answer)
      @message = "You can't vote for own answer"
    else
      if current_user.voted?(@answer, params[:positive])
        current_user.votes.where(object_id: @answer, positive: params[:positive]).first.destroy
        @message = "Answer's Raiting is changed"
      else
        @vote = current_user.votes.new(object_id: params[:answer_id], positive: params[:positive])
        
        if @vote.save
          @message = "Answer's Raiting is changed"
        else
          @message = @vote.errors.messages
        end
      end
    end
  end

end