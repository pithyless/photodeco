ActiveAdmin.setup do |config|
  config.site_title = "Photodeco"

  config.default_namespace = :admin

  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user

  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :get

  # Admin comments allow you to add comments to any model for admin use
  config.allow_comments_in = [:admin]

  # == Controller Filters
  # config.before_filter :do_something_awesome


  # == Register Stylesheets & Javascripts
  #
  # We recommend using the built in Active Admin layout and loading
  # up your own stylesheets / javascripts to customize the look
  # and feel.
  #
  # To load a stylesheet:
  #   config.register_stylesheet 'my_stylesheet.css'
  #
  # To load a javascript file:
  #   config.register_javascript 'my_javascript.js'
end
