require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:another_answer) { create(:answer, question: question) }
  let(:another_question) { create(:question) }
  let!(:vote_for_answer) { create(:vote_for_answer, object: another_answer, user: user, value: 1, object_type: 'Answer')}
  let!(:vote_for_question) { create(:vote_for_question, object: another_question, user: user, value: 1, object_type: 'Question')}

  it 'user authority on another_answer' do
    expect( user.author_of?(another_answer) ).to be_falsey 
  end
  
  it 'user authority on own answer' do
    expect( user.author_of?(answer) ).to be_truthy 
  end

  it 'user voted or not for answer' do
    expect( user.voted?(another_answer, 1) ).to be_truthy
  end

  it 'user voted or not for question' do
    expect( user.voted?(another_question, 1) ).to be_truthy
  end

end
