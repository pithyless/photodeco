class Photo < ActiveRecord::Base
  mount_uploader :image, OriginalPhotoUploader

  belongs_to :provider

  validates :provider,    :presence => true
  validates :title,     :presence => true, :length => (2..120)

  validates_presence_of :image
  validates_integrity_of :image
  validates_processing_of :image

  before_validation :strip_fields

  def strip_fields
    [:title].each { |v| self[v] = (self[v]||'').strip }
  end

  attr_accessible :title, :description, :author, :credit,
                  :source, :copyright, :notes, :taken_at,
                  :digitized_at, :image

end
