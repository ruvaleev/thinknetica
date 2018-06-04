class AnswersController < ApplicationController
  include Voted
  before_action :authenticate_user!
  before_action :load_question, only: [ :create, :award ]
  before_action :load_answer, except: [ :create ]
  after_action :publish_answer, only: [ :create ]

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

  def award
    @answer.make_best if current_user.author_of?(@question)
  end

  def update
    @question = @answer.question
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

  def publish_answer
    return if @answer.errors.any?
    renderer = ApplicationController.renderer.new
    renderer.instance_variable_set(:@env, { "HTTP_HOST"=>"localhost:3000",  
                                            "HTTPS"=>"off",   
                                            "REQUEST_METHOD"=>"GET",   
                                            "SCRIPT_NAME"=>"",   
                                            "warden" => warden })
    ActionCable.server.broadcast(
      'answers', @answer.to_json
    )
  end
end