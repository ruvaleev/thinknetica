class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question
  before_action :load_answer, only: [ :destroy ]

  def create 
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    flash[:notice] = 'You have to log in to create Answer' unless current_user.present?
    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
    else
      render 'error'
    end
    
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:notice] = 'Your answer successfully deleted.'
    else
      flash[:notice] = 'You can delete only your own answer!'
    end
    redirect_to @question
  end

private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end