module Ratable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :object, dependent: :destroy
  end

  def rating
    self.votes.sum(:value)
  end

  def vote(user, value)
    if user.voted?(self, value)
      self.votes.where(object_type: self.model_name.name, user_id: user, value: value).first.destroy
    else
      self.votes.create(user: user, value: value)
      # if @vote.save
      #   @message = "#{@vote.object_type}'s Raiting is changed"
      # else
      #   @message = @vote.errors.messages
      # end
    end
  end

end