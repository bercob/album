Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_region] = ENV['AWS_REGION']
Paperclip::Attachment.default_options[:s3_host_name] = "s3.#{Paperclip::Attachment.default_options[:s3_region]}.amazonaws.com"
Paperclip::Attachment.default_options[:s3_credentials] = {access_key_id: ENV['AWS_KEY'], secret_access_key: ENV['AWS_SECRET']}
Paperclip::Attachment.default_options[:bucket] = ENV['S3_BUCKET_NAME']

# from config file
PHOTO_STYLE_THUMB = Rails.application.config_for(:general)['photo_style_thumb']
raise 'photo_style_thumb value is not defined in general.yml' if PHOTO_STYLE_THUMB.blank?

PHOTO_STYLE_ORIGINAL = Rails.application.config_for(:general)['photo_style_original']
raise 'photo_style_original value is not defined in general.yml' if PHOTO_STYLE_ORIGINAL.blank?

PHOTO_CONVERT_OPTIONS = Rails.application.config_for(:general)['photo_convert_options']
raise 'photo_convert_options value is not defined in general.yml' if PHOTO_CONVERT_OPTIONS.blank?

PHOTO_CONTENT_TYPES = Rails.application.config_for(:general)['photo_content_types']
raise 'photo_content_types value is not defined in general.yml' if PHOTO_CONTENT_TYPES.blank?
