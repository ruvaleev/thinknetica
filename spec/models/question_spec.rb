require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { create(:question) }
  let!(:answer) { create_list(:answer, 4, question: question) }
  let(:best_answer) { create(:answer, question: question) }

  it { should have_many(:answers).dependent(:destroy) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many :attachments }

  it 'return not awarded answers' do
    best_answer.make_best
    expect( question.not_awarded_answers.length ).to eq(4)
  end
end