require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:another_answer) { create(:answer, question: question) }

  describe "POST #create" do
    sign_in_user
    context "create with valid attributes" do
      it "saves the new answer into the database" do        
      expect { post :create, params: { question_id: question,answer: attributes_for(:answer) } }.to change(Answer, :count).by(1)
      end

      it "redirects to question path" do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        redirect_to question_path(assigns(:question))
      end
    end

    context "create with invalid attributes" do
      let(:invalid_answer) { build(:invalid_answer, question: question, user_id: user.id) }
      it "doesn't save a new answer into the database" do
        expect { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) } }.to_not change(Answer, :count)
      end

      it "re-renders new view" do
        post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) }
        redirect_to question_path(assigns(:question))
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    it "deletes other user's answer" do
      another_answer
      expect { delete :destroy, params: { question_id: question, id: another_answer } }.to change(Answer, :count).by(0)
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
end