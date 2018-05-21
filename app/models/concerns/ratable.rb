module Ratable
  extend ActiveSupport::Concern

  def rating
    Vote.where(object_id: self.id, positive:true).count - Vote.where(object_id: self.id, positive:false).count
  end

  def vote(user, positive)
    if user.voted?(self, positive)
      Vote.where(object_id: self, object_type: self.model_name.name, user_id: user).first.destroy
    else
      @vote = self.votes.new(user: user, positive: positive)
      if @vote.save
        @message = "#{@vote.object_type}'s Raiting is changed"
        logger.debug "сохранили"
      else
        @message = @vote.errors.messages
        logger.debug "@vote имеет ошибки #{@vote.errors.messages}"
      end
    end
  end

end