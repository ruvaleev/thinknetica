require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let (:user) { nil }
    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let (:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let (:user) { create :user }
    let (:another_user) { create :user }
    let (:own_question) {create :question, user: user }
    let (:not_own_question) {create :question }
    let (:own_answer) { create :answer, user: user }
    let (:not_own_answer) { create :answer }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Question }
    it { should be_able_to :read, Comment }

    it { should be_able_to :update, create(:question, user: user), user: user }
    it { should_not be_able_to :update, create(:question, user: another_user), user: user }

    it { should be_able_to :update, create(:answer, user: user), user: user }
    it { should_not be_able_to :update, create(:answer, user: another_user), user: user }

    it { should be_able_to :update, create(:comment, user: user), user: user }
    it { should_not be_able_to :update, create(:comment, user: another_user), user: user }

    it { should be_able_to :destroy, create(:question, user: user), user: user }
    it { should_not be_able_to :destroy, create(:question, user: another_user), user: user }

    it { should be_able_to :destroy, own_answer, user: user }
    it { should_not be_able_to :destroy, not_own_answer, user: user }

    it { should be_able_to :destroy, create(:comment, user: user), user: user }
    it { should_not be_able_to :destroy, create(:comment, user: another_user), user: user }

    it { should be_able_to :destroy, create(:attachment, attachable: own_answer), user: user }
    it { should_not be_able_to :destroy, create(:attachment, attachable: not_own_answer), user: user }

    it { should be_able_to :create_vote, create(:question, user: another_user), user: user }
    it { should_not be_able_to :create_vote, create(:question, user: user), user: user }
    
    it { should be_able_to :create_vote, not_own_answer, user: user }
    it { should_not be_able_to :create_vote, own_answer, user: user }

    it { should be_able_to :award, create(:answer, question: own_question), user: user }
    it { should_not be_able_to :award, create(:answer, question: not_own_question), user: user }
  end
end