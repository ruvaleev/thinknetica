class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_attachment

  authorize_resource

  def destroy
    @attachment.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  
  def load_attachment
    @attachment = Attachment.find(params[:id])
  end

end