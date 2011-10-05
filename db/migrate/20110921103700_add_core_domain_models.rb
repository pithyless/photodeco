class AddCoreDomainModels < ActiveRecord::Migration
  def change

    create_table :providers do |t|
      t.string   :name,            :null => false, :limit => 120
      t.string   :slug,            :null => false, :limit => 60

      t.timestamps
    end

    create_table :photos do |t|
      t.integer  :provider_id,     :null => false, :index => :unique

      t.string   :title,           :null => false, :limit => 120
      t.text     :description

      t.string   :author
      t.text     :credit
      t.text     :source
      t.text     :copyright
      t.text     :notes
      t.datetime :taken_at
      t.datetime :digitized_at

      t.string   :image,                       :null => false
      t.string   :image_secure_token,          :null => false, :limit => 10, :index => :unique
      t.string   :image_original_secure_token, :null => false, :limit => 10, :index => :unique
      t.string   :image_original_filename,     :null => false, :limit => 120

      t.boolean  :moderated

      t.timestamps
    end

    create_table :stores do |t|
      t.string  :name,          :null => false, :limit => 120
      t.string  :slug,          :null => false, :limit => 120, :index => :unique
      t.string  :domain,        :null => false, :limit => 120, :index => :unique

      t.timestamps
    end

    create_table :products do |t|
      t.integer :photo_id,      :null => false
      t.integer :store_id,      :null => false, :index => { :with => :photo_id, :unique => true }

      t.boolean :published

      t.timestamps
    end

  end
end
