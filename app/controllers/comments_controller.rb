class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer

  def create
    @comment = @answer.comments.create(user: current_user, body: params[:comment][:body])
    respond_to do |format|
      format.json { render json: { comment: @comment } }
    end
  end

  private

  def find_answer
    @answer = Answer.find(params[:answer_id])
  end

end
