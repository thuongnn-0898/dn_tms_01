class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  process resize_to_limit: [Settings.minimagick_width,
                            Settings.minimagick_height]

  version :thumb do
    process resize_to_fill: [Settings.minimagick_width_thumb,
                             Settings.minimagick_height_thumb]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url *_args
    "/assets/" + [version_name, Settings.avatar_default].compact.join("_")
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
