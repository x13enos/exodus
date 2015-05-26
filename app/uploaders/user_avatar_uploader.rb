class UserAvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def extension_white_list
    %w(jpg jpeg gif png)
  end


  version :mini do
    process resize_to_fit: [50,50]
  end

  version :thumb do
    process resize_to_fit: [150,150]
  end

end
