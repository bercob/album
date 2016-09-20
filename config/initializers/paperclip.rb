Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_region] = ENV['AWS_REGION']
Paperclip::Attachment.default_options[:s3_host_name] = "s3.#{Paperclip::Attachment.default_options[:s3_region]}.amazonaws.com"
Paperclip::Attachment.default_options[:s3_credentials] = {access_key_id: ENV['AWS_KEY'], secret_access_key: ENV['AWS_SECRET']}
Paperclip::Attachment.default_options[:bucket] = ENV['S3_BUCKET_NAME']
