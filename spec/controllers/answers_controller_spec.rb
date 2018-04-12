require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:another_answer) { create(:another_answer, question: question) }

  describe "POST #create" do
    sign_in_user
    context "create with valid attributes" do
      it "saves the new answer into the database" do        
      expect { post :create, params: { question_id: question,answer: attributes_for(:answer), format: :js } }.to change(question.answers, :count).by(1)
      end

      it "saves the new answer with an attributes of user" do
        post :create, params: { question_id: question,answer: attributes_for(:answer), format: :js }
        expect(answer.user_id).to eq(user.id)
      end

      it "saves the new answer with an attributes of question" do
        post :create, params: { question_id: question,answer: attributes_for(:answer), format: :js }
        expect(answer.question_id).to eq(question.id)
      end

      it "redirects to question path" do
        post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js }
        redirect_to question_path(assigns(:question))
      end
    end

    context "create with invalid attributes" do
      let(:invalid_answer) { build(:invalid_answer, question: question, user_id: user.id, format: :js) }
      it "doesn't save a new answer into the database" do
        expect { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer), format: :js } }.to_not change(Answer, :count)
      end

      it "re-renders new view" do
        post :create, params: { question_id: question, answer: attributes_for(:invalid_answer), format: :js }
        redirect_to question_path(assigns(:question))
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    it "deletes other user's answer" do
      another_answer
      expect { delete :destroy, params: { question_id: question, id: another_answer } }.to_not change(Answer, :count)
    end

    it 'deletes own answer' do
      sign_in(user)
      answer
      expect { delete :destroy, params: { question_id: question, id: answer } }.to change(Answer, :count).by(-1)
    end


    it 'redirect to question' do
      delete :destroy, params: { question_id: question, id: answer }
      redirect_to question_path(assigns(:question))
    end
  end

  describe 'PUT #update' do
    sign_in_user

    context 'valid attributes' do
      it 'assigns the requested answer to @answer' do 
        patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer), format: :js }
        expect(assigns(:answer)).to eq answer
      end     

      it 'changes answer attributes' do
        patch :update, params: { id: answer, question_id: question, answer: { body: 'new body' }, format: :js }
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'render update template' do
        patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :update
      end
    end
  end

end