class AttachmentUploader < CarrierWave::Uploader::Base
  storage :fog
end
