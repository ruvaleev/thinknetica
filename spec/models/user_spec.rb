require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:another_answer) { create(:answer, question: question) }

  it 'user authority on another_answer' do
    expect( user.author_of?(another_answer) ).to be_falsey 
  end
  
  it 'user authority on own answer' do
    expect( user.author_of?(answer) ).to be_truthy 
  end

end
