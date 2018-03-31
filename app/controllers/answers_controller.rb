class AnswersController < ApplicationController
  before_action :load_question

  def new
    @answer = @question.answers.new
    @answer.update(user_id: current_user)
    if @answer.save
      redirect_to @question
    else
      render :new
    end
  end

  def create 
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
      redirect_to @question
    else
      flash[:notice] = 'You have to log in for asking'
      render :new
    end
  end

private

  def load_question
  	@question = Question.find(params[:question_id])
  end

  def success_comeback

  end

  def answer_params
  	params.require(:answer).permit(:body)
  end
end
