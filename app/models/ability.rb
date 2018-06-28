class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment]
    can :update, [Question, Answer, Comment], user: user
    can :destroy, [Question, Answer, Comment], user: user
    can :destroy, Attachment do |attachment| 
      attachment.attachable.user == user 
    end
    can :create_vote, [Question, Answer]
    cannot :create_vote, [Question, Answer], user: user
    can :award, Answer do |answer| 
      answer.question.user == user 
    end
  end
end
