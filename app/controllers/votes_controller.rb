class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @object_type = params[:object_type]
    if @object_type == 'Question'
      @object = Question.find(params[:resource_id])
    else
      @object = Answer.find(params[:resource_id])
    end
    @vote = @object.vote(current_user, params[:value])
  end

end