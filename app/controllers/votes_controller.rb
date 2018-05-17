class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @object_type = params[:object_type]
    if @object_type == 'Question'
      @question = Question.find(params[:resource_id])
      @object = @question
    else
      @answer = Answer.find(params[:resource_id])
      @object = @answer
    end
    if current_user.author_of?(@object)
      @message = "You can't vote for own #{params[:object_type].downcase}"
    else
      if current_user.voted?(@object, params[:positive], params[:object_type])
        current_user.votes.where(object_id: @object.id, positive: params[:positive], object_type: params[:object_type]).first.destroy
        @message = "#{params[:object_type]}'s Raiting is changed"
      else
        @vote = current_user.votes.new(object_id: @object.id, positive: params[:positive], object_type: params[:object_type])
        
        if @vote.save
          @message = "#{params[:object_type]}'s Raiting is changed"
        else
          @message = @vote.errors.messages
        end
      end
    end
  end

end