class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question
  before_action :load_answer, except: [:create]

  def create 
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    flash[:notice] = 'You have to log in to create Answer' unless current_user.present?
    respond_to do |format|
      if @answer.save
        format.json { render json: @answer }
      else
        format.json { render json: @answer.errors.full_messages, status: :unprocessible_entity }
      end
    end
  end

  def award
    @answer.make_best if current_user.author_of?(@question)
  end

  def update
    @answer.update(answer_params) if current_user.author_of?(@answer)
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      @notice = 'Your answer successfully deleted.'
    else
      @notice = 'You can delete only your own answer!'
    end
  end

private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end
end