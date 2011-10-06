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
                  :copyright, :notes, :taken_at, :digitized_at, :moderated,
                  :image, :provider_id

  before_validation :hardcode_provider
  before_validation :parse_image_metadata

  def hardcode_provider
    # Temporary - always set to Forum
    self[:provider_id] = Provider.find_by_slug!('agencja-forum')
  end

  class MetaPhoto
    IGNORED_TAGS = ['Iptc.Application2.0x00bb', 'Iptc.Application2.0x00f0',
                    'Iptc.Application2.0x00e7']
    # DATE_TAGS = ['Iptc.Application2.DateCreated', 'Exif.Image.DateTime']

    def initialize
      @meta = Hash.new { |h, k| h[k] = [] }
    end

    def []=(key, value)
      key   = ::ActiveSupport::Inflector.transliterate(key)
      return nil if IGNORED_TAGS.include? key
      value = ::ActiveSupport::Inflector.transliterate(value)
      @meta[key] << value
    end

    def [](key)
      value = @meta[key]
      case value.length
      when 0; nil
      when 1; value[0]
      else;   value
      end
    end

    def iptc(key)
      case key
      when /\w+\.\w+\.\w+/
        self[key]
      when /\w+\.\w+/
        self['Iptc.' + key]
      else
        self['Iptc.Application2.' + key]
      end
    end

    def exif(key)
      case key
      when /\w+\.\w+\.\w+/
        self[key]
      when /\w+\.\w+/
        self['Exif.' + key]
      else
        self['Exif.Image.' + key]
      end
    end

    def each &blk
      @meta.keys.each do |k|
        blk.call([k, self[k]])
      end
    end

    def digitized_at
      require 'chronic'
      # TODO: 2011:07:22 09:44:53 - meta.exif('DateTime')
      v = self.iptc('DateCreated') || self.exif('DateTime')
      Chronic::parse(v)
    end

    def keywords
      Array(self.iptc('Keywords')).join(', ')
    end
  end

  def parse_image_metadata
    image = Exiv2::ImageFactory.open(self.image.file.path)
    image.read_metadata

    meta = MetaPhoto.new

    image.iptc_data.each do |key, value|
      meta[key] = value
    end
    image.exif_data.each do |key, value|
      meta[key] = value
    end

    self[:title] = meta.iptc('Headline')
    self[:description] = [meta.iptc('Headline'), meta.iptc('Byline'),
                          meta.iptc('Caption')].compact.join("\n\n")
    self[:author] = meta.iptc('Writer')
    self[:credit] = meta.iptc('Credit')
    self[:source]
    self[:copyright] = [meta.iptc('Copyright'),
                        meta.iptc('SpecialInstructions')].compact.join("\n\n")
    self[:taken_at]     = meta.digitized_at
    self[:digitized_at] = meta.digitized_at

    notes = []
    notes << "Keywords: #{meta.keywords} ||"
    meta.each { |k,v| notes << "#{k} => #{v}" }
    self[:notes] = notes.join("\n")

    # TODO
    self[:image_original_filename] = self.image.file.original_filename
    self[:image_original_secure_token] = 'secretOne'
    self[:image_secure_token] = 'secretTwo'
  end
end
