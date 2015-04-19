# Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:s3_host_name] = ENV["S3_HOST_NAME"]

Paperclip.interpolates(:s3_sg_url) { |attachment, style|
  "#{attachment.s3_protocol}://s3-ap-southeast-1.amazonaws.com/#{attachment.bucket_name}/#{attachment.path(style).gsub(%r{^/},
  "")}"
}