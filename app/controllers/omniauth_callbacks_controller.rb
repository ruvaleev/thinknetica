class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def vkontakte
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'vkontakte') if is_navigational_format?
    end
  end

  def facebook
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'facebook') if is_navigational_format?
    end
  end

end