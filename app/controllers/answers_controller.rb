class AnswersController < ApplicationController
  include Voted
  before_action :authenticate_user!
  before_action :load_question, only: [ :create, :award ]
  before_action :load_answer, except: [ :create ]
  after_action :publish_answer, only: [ :create ]

  respond_to :js, only: [ :create, :destroy ]

  authorize_resource

  def create 
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    if @answer.save
      respond_with @answer
    else
      render 'error'
    end
  end

  def award
    @answer.make_best
  end

  def update
    @question = @answer.question
    @answer.update(answer_params)
  end

  def destroy
    respond_with @answer.destroy
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
    ActionCable.server.broadcast( "answers_#{@question.id}", {
      answer: @answer.to_json,
      attachments: @answer.attachments.to_json
    })
  end
end