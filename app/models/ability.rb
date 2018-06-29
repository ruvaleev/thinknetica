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
    can :update, [Question, Answer, Comment], user_id: user.id
    can :destroy, [Question, Answer, Comment], user_id: user.id
    
    can :destroy, Attachment do |attachment| 
      user.author_of?(attachment.attachable) 
    end
    
    can :create_vote, [Question, Answer] do |object|
      !user.author_of?(object)
    end
    
    can :award, Answer do |answer| 
      user.author_of?(answer.question) 
    end
  end
end
