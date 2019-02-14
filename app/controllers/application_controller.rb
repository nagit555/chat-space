class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate
  #before_action :authenticate_user!

  # deviseのサインイン後の遷移
  def after_sign_up_path_for(resource)
    root_path
  end

  # deviseのサインイン後の遷移
  def after_sign_in_path_for(resource)
    root_path
  end

  # deviseのサインアウト後の遷移
  def after_sign_out_path_for(resource)
    root_path
  end

  private
    def authenticate
      authenticate_user!
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
