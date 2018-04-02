require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:another_answer) { create(:answer, question: question) }

  it "should to indicate the users authorship" do
    user.author_of?(another_answer).should be false
    user.author_of?(answer).should be true
    user.author_of?(question).should be true
  end
end
