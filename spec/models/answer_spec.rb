require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let!(:former_best_answer) { create(:answer, question: question, award: true) }
  
  it { should belong_to :question }
  it { should validate_presence_of :body }

  it 'makes best' do
    answer.make_best
    expect( answer.award ).to be_truthy 
  end

  it 'former best answer is not the best now' do
    answer.make_best
    former_best_answer.reload
    expect( former_best_answer ).to_not be_award
  end
end