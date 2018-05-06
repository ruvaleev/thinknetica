class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [ :show, :index ]
  before_action :load_question, only: [ :show, :edit, :update, :destroy ]
  
  def index
    @questions = Question.all
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

  private

  def load_question
  	@question = Question.find(params[:id])
  end

  def question_params
  	params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_destroy])
  end
end

__END__
Работающий
Processing by QuestionsController#create as HTML
  Parameters: {"utf8"=>"✓", "authenticity_token"=>"QtiKBq3lxuqBhisHnTaU2yu8sUygU2kem4DpoARzkEb9dAaHQn+/djAHisWZXkZQVAVtEWH1M/wRBs37vtzB5Q==", "question"=>{"title"=>"One file", "body"=>"attachment", "attachments_attributes"=>{"0"=>{"file"=>#<ActionDispatch::Http::UploadedFile:0x00007fcad2ced7a0 @tempfile=#<Tempfile:/tmp/RackMultipart20180503-7866-g6c9fk.rb>, @original_filename="spec_helper.rb", @content_type="application/x-ruby", @headers="Content-Disposition: form-data; name=\"question[attachments_attributes][0][file]\"; filename=\"spec_helper.rb\"\r\nContent-Type: application/x-ruby\r\n">}}, "_destroy"=>"false"}, "commit"=>"Create"}

Неработающий
Processing by QuestionsController#create as HTML
  Parameters: {"utf8"=>"✓", "authenticity_token"=>"tbI82hVjuGFADeolIGlw1eVfSOnYxF//rBy8Z/UI/90KHrBb+vnB/fGMS+ckAaJemuaUtBliBR0mmpg8T6eufg==", "question"=>{"title"=>"Two files ", "body"=>"attachments", "attachments_attributes"=>{"0"=>{"file"=>#<ActionDispatch::Http::UploadedFile:0x00007fcad1edbd88 @tempfile=#<Tempfile:/tmp/RackMultipart20180503-7866-1wxio39.rb>, @original_filename="spec_helper.rb", @content_type="application/x-ruby", @headers="Content-Disposition: form-data; name=\"question[attachments_attributes][0][file]\"; filename=\"spec_helper.rb\"\r\nContent-Type: application/x-ruby\r\n">}, "1525361520862"=>{"attachments"=>{"file"=>#<ActionDispatch::Http::UploadedFile:0x00007fcad1edb978 @tempfile=#<Tempfile:/tmp/RackMultipart20180503-7866-2qcgw3.rb>, @original_filename="rails_helper.rb", @content_type="application/x-ruby", @headers="Content-Disposition: form-data; name=\"question[attachments_attributes][1525361520862][attachments][file]\"; filename=\"rails_helper.rb\"\r\nContent-Type: application/x-ruby\r\n">}, "_destroy"=>"false"}}, "_destroy"=>"false"}, "commit"=>"Create"}
