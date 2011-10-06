ActiveAdmin.setup do |config|
  config.site_title = "Photodeco"

  config.default_namespace = :admin

  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user

  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :delete

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

  # TODO:
  # config.register_stylesheet '/javascripts/plupload/jquery.plupload.queue/css/jquery.plupload.queue.css'
  # config.register_stylesheet '/javascripts/plupload/jquery.ui.plupload/css/jquery.ui.plupload.css'

  # config.register_javascript '/javascripts/plupload/plupload.js'
  # config.register_javascript '/javascripts/plupload/plupload.html5.js'
  # config.register_javascript '/javascripts/plupload_loader.js'
end
