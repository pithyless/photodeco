class ApplicationController < ActionController::Base
  protect_from_forgery

  check_authorization :unless => :devise_controller?

  # Override build_footer method in ActiveAdmin::Views::Pages
  require 'active_admin_views_pages_base.rb'

  def raise_forbidden
    fail 'Forbidden'
  end

  def raise_not_found(msg='')
    raise ActionController::RoutingError.new("Not Found: #{msg}")
  end

  # required for ActiveAdmin
  def authenticate_admin_user!
    raise_forbidden if user_signed_in? && !current_user.admin?
    authenticate_user!
  end

  def current_admin_user
    return nil if user_signed_in? && !current_user.admin?
    current_user
  end
end
