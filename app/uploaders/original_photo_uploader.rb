# encoding: utf-8

class OriginalPhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  # def store_path(for_file = filename)
  #   File.join([Rails.root, store_dir, full_filename(for_file)].compact)
  #   # TODO:  self.model.class.name.underscore.pluralize + "/" + self.model.slug + "/" + (version_name || :original).to_s + ".jpg"
  # end


  # process :store_color_histogram

  # def store_color_histogram
  #   manipulate! do |img|
  #     if model
  #       model.colors = img.quantize(5).color_histogram.map do |c|
  #         c.first.to_color(Magick::X11Compliance,true,8,true)
  #       end
  #     end
  #     img = yield(img) if block_given?
  #     img
  #   end
  # end


  version :square do
    process :resize_to_fill => [120, 120]
  end

  version :medium do
    # TODO: watermark
    process :resize_to_fit => [500, 500]
  end

  version :large do
    # TODO: watermark
    process :resize_to_fit => [1024, 1024]
  end

  def extension_white_list
    %w(jpg jpeg)
  end

end
