class Photo < ActiveRecord::Base
  schema_validations :except => [:image]

  mount_uploader :image, OriginalPhotoUploader

  belongs_to :provider

  validates :title, :length => (2..120)

  validates_presence_of :image
  validates_integrity_of :image
  validates_processing_of :image

  before_validation :strip_fields

  def strip_fields
    [:title].each { |v| self[v] = (self[v]||'').strip }
  end

  attr_accessible :title, :description, :author, :credit, :source,
                  :copyright, :notes, :taken_at, :digitized_at,
                  :image, :provider_id

  before_validation :parse_image_metadata

  def parse_image_metadata
    # TODO
    self[:image_original_filename] = 'todo.jpg'
    self[:image_original_secure_token] = 's3cr3t2'
    self[:image_secure_token] = 's3cr3t1'
  end
end
