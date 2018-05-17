require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let!(:former_best_answer) { create(:answer, question: question, award: true) }
  let!(:votes_for_answer) { create_list(:vote_for_answer, 4, object: answer, positive: true) }
  let!(:vote_against_answer) { create(:vote_for_answer, object: answer, positive: false) }

  it { should belong_to :question }
  it { should validate_presence_of :body }
  it { should have_many :attachments }
  it { should accept_nested_attributes_for :attachments }
  it { should have_many(:votes).dependent(:destroy) }

  it 'makes best' do
    answer.make_best
    expect( answer.award ).to be_truthy 
  end

  it 'former best answer is not the best now' do
    answer.make_best
    former_best_answer.reload
    expect( former_best_answer ).to_not be_award
  end

  it 'return rating of answer' do
    expect( answer.rating ).to eq(3)
  end
end