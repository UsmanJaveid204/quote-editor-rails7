class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  protected

  def context
    {
      current_user: current_user
    }
  end

  def redirect_to_back(**opts)
    if params[:back_path].present?
      redirect_to params[:back_path], **opts
    else
      redirect_back fallback_location: root_path, **opts
    end
  end

  private

  def current_company
    @current_company ||= current_user.company if user_signed_in?
  end

  helper_method :current_company
end
