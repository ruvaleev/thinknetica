class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @vote = current_user.votes.new(answer_id: params[:answer_id], positive: params[:positive])
    @vote.save
    @answer = Answer.find(@vote.answer_id)
  end

end