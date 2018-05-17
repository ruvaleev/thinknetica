require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:user) { create(:user) }
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question) }
  let(:vote_for_answer) { create(:vote_for_answer, user: user, object: answer) }
  let(:vote_for_question) { create(:vote_for_question, user: user, object: question) }
  

  describe 'POST #create' do
    before { sign_in(user) }

    it "creates vote for answer" do
      expect { post :create, params: { resource_id: answer, format: :js } }.to change(Vote, :count).by(1)
    end
    it "creates vote for question" do
      expect { post :create, params: { resource_id: question, object_type:'Question', format: :js } }.to change(Vote, :count).by(1)
    end
    it "deletes vote for answer" do
      vote_for_answer
      expect { post :create, params: { resource_id: answer, object_type:'Answer', format: :js } }.to change(Vote, :count).by(-1)
    end
    it "deletes vote for question" do
      vote_for_question
      expect { post :create, params: { resource_id: question, object_type:'Question', format: :js } }.to change(Vote, :count).by(-1)
    end
  end
end