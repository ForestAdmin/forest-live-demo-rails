require 'aws-sdk-s3'

class Forest::S3Helper
  # Regexp to match the RFC2397 prefix.
  REGEXP = /\Adata:([-\w]+\/[-\w\+\.]+)?;base64,(.*)/m

  Aws.config.update({
    region: ENV['S3_REGION'],
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], 
                                      ENV['AWS_SECRET_ACCESS_KEY'])
  })

  def initialize
    # Create the S3 client.
    @s3 = Aws::S3::Resource.new
    @bucket = @s3.bucket(ENV['S3_BUCKET'])
  end

  def upload(raw_data, filename)
    # Parse the "data" URL scheme (RFC 2397).
    data_uri_parts = raw_data.match(REGEXP) || []

    # Upload the image.
    @bucket.object(filename).put(opts(data_uri_parts))
  end

  def files(prefix)
    @bucket.objects(prefix: prefix).map do |file|
      {
        id: file.key.gsub('livedemo/legal/', ''),
        url: "https://s3-#{ENV['S3_REGION']}.amazonaws.com/#{ENV['S3_BUCKET']}/#{file.key}",
        last_modified: file.last_modified,
        size: Filesize.from("#{file.size} B").pretty
      }
    end
  end

  def file(key)
    file = @bucket.objects(prefix: "livedemo/legal/#{key}").try(:first)
    if (file)
      {
        id: file.key.gsub('livedemo/legal/', ''),
        url: "https://s3-#{ENV['S3_REGION']}.amazonaws.com/#{ENV['S3_BUCKET']}/#{file.key}",
        last_modified: file.last_modified,
        size: Filesize.from("#{file.size} B").pretty
      }
    end
  end

  def delete_file(key)
    @bucket.objects(prefix: "livedemo/legal/#{key}").try(:first).try(:delete)
  end

  private

  def extension(data_uri_parts)
    Mime::Type.lookup(data_uri_parts[1]).symbol.to_s
  end

  def filetype(data_uri_parts)
    Mime::Type.lookup(data_uri_parts[1]).to_s
  end

  def filename(data_uri_parts)
    ('a'..'z').to_a.shuffle[0..7].join + ".#{extension(data_uri_parts)}"
  end

  def opts(data_uri_parts)
    {
      body: data_uri_parts[2],
      content_encoding: 'base64',
      content_disposition: 'inline',
      content_type: filetype(data_uri_parts),
      acl: 'public-read'
    }
  end
end
