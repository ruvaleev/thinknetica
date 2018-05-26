class VotesController < ApplicationController
  before_action :authenticate_user!

  protected

  def create_vote
    @vote = @object.vote(current_user, params[:value])
    respond_to do |format|
      format.json { render json: { vote: @vote, rating: @object.rating } }
    end
  end

end