ActiveAdmin.register User do
  controller.authorize_resource

  filter :email
  filter :first_name
  filter :last_name
  filter :role, :as => :check_boxes, :collection => proc {User::ROLES.reverse}

  index do
    column :first_name
    column :last_name
    column :email
    column :role
    column :last_sign_in_at
    default_actions
  end

  form do |f|
    f.inputs "User details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
end
