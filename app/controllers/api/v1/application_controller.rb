class Api::V1::ApplicationController < ActionController::Base
  def sign_upload
    render json: {
      acl: 'public-read',
      awsaccesskeyid: ENV['AWS_ACCESS_KEY_ID'],
      bucket: bucket,
      expires: 10.hours.from_now,
      key: "uploads/#{params[:name]}",
      policy: policy,
      signature: signature,
      success_action_status: '201',
      'Content-Type' => params[:type],
      'Cache-Control' => 'max-age=630720000, public'
    }, status: :ok
  end

  def signature
    Base64.encode64(
      OpenSSL::HMAC.digest(
        OpenSSL::Digest::Digest.new('sha1'),
        ENV['AWS_SECRET_ACCESS_KEY'],
        policy({ secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] })
      )
    ).gsub(/\n/, '')
  end

  def hmac_sha256(key, input)
    OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new("sha256"), key, input)
  end

  def sha256(input)
    OpenSSL::Digest::Digest::SHA256.new(input).to_s
  end

  def sign_delete
    now = Time.now.utc
    region = ENV['AWS_REGION']

    k_secret = ENV['AWS_SECRET_ACCESS_KEY']
    k_date = hmac_sha256("AWS4" + k_secret, now.strftime("%Y%m%d"))
    k_region = hmac_sha256(k_date, region)
    k_service = hmac_sha256(k_region, "s3")
    k_signing = hmac_sha256(k_service, "aws4_request")

    simple_date = now.strftime("%Y%m%d")
    iso8601_date = now.strftime("%Y%m%dT%H%M%SZ")
    empty_string_sha256 = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

    canonical_request = "DELETE\n/uploads/#{params[:name]}\n\nhost:#{bucket}.s3.amazonaws.com\nx-amz-date:#{iso8601_date}\n\nhost;x-amz-date\n#{empty_string_sha256}"

    string_to_sign = "AWS4-HMAC-SHA256\n#{iso8601_date}\n#{simple_date}/#{ENV['AWS_REGION']}/s3/aws4_request\n#{sha256(canonical_request)}"

    signature = Digest::hexencode(hmac_sha256(k_signing, string_to_sign))
    signature
    render json: {
      signature: signature, 
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      success_action_status: '201',
      iso8601_date: iso8601_date,
      simple_date: simple_date,
      region: region
    }, status: :ok
  end

  def policy(options = {})
    Base64.encode64(
      {
        expiration: 10.hours.from_now,
        conditions: [
          { bucket: bucket },
          { acl: 'public-read' },
          { expires: 10.hours.from_now },
          { success_action_status: '201' },
          [ 'starts-with', '$key', '' ],
          [ 'starts-with', '$Content-Type', '' ],
          [ 'starts-with', '$Cache-Control', '' ],
          [ 'content-length-range', 0, 524288000 ]
        ]
      }.to_json
    ).gsub(/\n|\r/, '')
  end
  
  def bucket
    ENV["AWS_S3_BUCKET_NAME_#{params['location-name'].upcase}"]
  end
end

