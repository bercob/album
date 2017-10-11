AWS.config(
    access_key_id:      ENV['AWS_KEY'],
    secret_access_key:  ENV['AWS_SECRET'],
    region:             ENV['AWS_REGION'],
    bucket:             ENV['S3_BUCKET_NAME']
)
