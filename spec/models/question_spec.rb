require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { create(:question) }
  let!(:answer) { create_list(:answer, 4, question: question) }
  let(:best_answer) { create(:answer, question: question) }
  let!(:votes_for_question) { create_list(:vote_for_question, 4, object: question, positive: true) }
  let!(:vote_against_question) { create(:vote_for_question, object: question, positive: false) }

  it { should have_many(:answers).dependent(:destroy) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should accept_nested_attributes_for :attachments }
  it { should have_many(:votes).dependent(:destroy) }

  it 'return not awarded answers' do
    best_answer.make_best
    expect( question.not_awarded_answers.length ).to eq(4)
  end

  it 'return rating of question' do
    expect( question.rating ).to eq(3)
  end
end