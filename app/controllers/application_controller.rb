class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :user_can_edit?

  def user_can_edit?(record)
    user_signed_in? && policy(record).edit?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  private

  def user_not_authorized(exception)
    flash[:alert] = t('global.not_authorized')
    redirect_to(request.referrer || root_path)
  end
end
