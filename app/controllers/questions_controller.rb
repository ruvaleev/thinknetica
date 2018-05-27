class QuestionsController < ApplicationController
  include Voted
  before_action :authenticate_user!, except: [ :show, :index ]
  before_action :load_question, only: [ :show, :edit, :update, :destroy, :vote ]
  
  def index
    @questions = Question.all
    @vote = Vote.new
  end

  def show
    @answer = @question.answers.new
    @best = @question.answers.best.first
    @answer.attachments.build
  end

  def new
  	@question = Question.new
    @question.attachments.build
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def update
  	@question.update(question_params)
  end

  def destroy
    if current_user.author_of?(@question)
    	@question.destroy
      flash[:notice] = 'Your question successfully deleted.'
    else
      flash[:notice] = 'You can destroy only your own questions!'
    end
    redirect_to questions_path
  end

  def create_vote
    @object = Question.find(params[:id])
    super
  end

  private

  def load_question
  	@question = Question.find(params[:id])
  end

  def question_params
  	params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_destroy])
  end
end