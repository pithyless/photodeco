ActiveAdmin.register Photo do
  controller.authorize_resource

  filter :title
  filter :description
  filter :moderated, :as => :select

  collection_action :upload, :method => :get do
    # render app/views/admin/photos/upload.html.erb
  end

  collection_action :upload_photo, :method => :post do
    # Do some CSV importing work here...
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end

  form :partial => "form"

  index :as => :grid, :columns => 5 do |photo|
    link_to(image_tag(photo.image.square), "/admin/photos/#{photo.id}")
    # TODO: AA bug -> admin_photos_path(photo) => "/admin/photos.7"
  end

  show do
    h3 photo.title
    div image_tag(photo.image.large)
    panel 'Details' do
      attributes_table_for photo do
        row :title
        row('Description') { simple_format photo.description }
        row :image_original_filename
        row('Photo Uploaded') { photo.created_at }
      end
    end
    panel 'Metadata' do
      attributes_table_for photo do
        row :author
        row :credit
        row :source
        row :copyright
        row :taken_at
        row :digitized_at
        row('Extra Notes') { simple_format photo.notes }
      end
    end
  end

  # form do |f|
  #   f.inputs "User details" do
  #     f.input :first_name
  #     f.input :last_name
  #     f.input :email
  #     f.input :password
  #     f.input :password_confirmation
  #   end
  #   f.buttons
  # end
end
