require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  describe "GET #new" do

    before { get :new, params: { question_id: question } }

    it "assigns an answer to the variable @answer" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do

    context "create with valid attributes" do
      it "saves the new answer into the database" do        
      expect { post :create, params: { answer: attributes_for(:answer) } }
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
        expect(response).to render_template :new
      end
    end
  end
end