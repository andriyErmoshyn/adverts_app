class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  include SessionsHelper
  include CanCan::ControllerAdditions

  alias_method :current_user, :current_member

  rescue_from CanCan::AccessDenied do
    flash[:warning] = "Sorry, you have no rights for this action."
    redirect_to root_url
  end

end
