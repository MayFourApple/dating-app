class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def linkedin
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to '/'
    end
  end

  def failure
    redirect_to '/'
  end

  # def token_params
  #   super.tap do |params|
  #     params.client_secret = options.client_secret
  #   end
  # end
end
