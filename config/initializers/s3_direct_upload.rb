S3DirectUpload.config do |c|
  c.access_key_id = ENV['AWS_KEY']
  c.secret_access_key = ENV['AWS_SECRET']
  c.bucket = ENV['S3_BUCKET_NAME']
  c.region = ENV['AWS_REGION']
  c.url = "https://s3.#{ENV['AWS_REGION']}.amazonaws.com/#{ENV['S3_BUCKET_NAME']}"
end
