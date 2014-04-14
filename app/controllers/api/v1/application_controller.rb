class Api::V1::ApplicationController < ActionController::Base
  def sign
    render json: {
      acl: 'public-read',
      awsaccesskeyid: ENV['AWS_ACCESS_KEY_ID'],
      bucket: ENV['AWS_S3_BUCKET_NAME_HOLLYWOOD'],
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
    k_secret = ENV['AWS_SECRET_ACCESS_KEY']
    k_date = hmac_sha256("AWS4" + k_secret, "20140414")
    puts k_date
    k_region = hmac_sha256(k_date, "us-west-2")
    puts k_region
    k_service = hmac_sha256(k_region, "s3")
    puts k_service
    k_signing = hmac_sha256(k_service, "aws4_request")
    puts 'k_signing ' + k_signing

    canonical_request = "DELETE\n/uploads/serveimage.jpg\n\nhost:assets.hollywood.com.s3.amazonaws.com\nx-amz-date:20140414T202915Z\n\nhost;x-amz-date\ne3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

    string_to_sign = "AWS4-HMAC-SHA256\n20140414T202915Z\n20140414/us-west-2/s3/aws4_request\n#{sha256(canonical_request)}"

    puts string_to_sign
    signature = hmac_sha256(k_signing, string_to_sign)
    signature
  end

  def policy(options = {})
    Base64.encode64(
      {
        expiration: 10.hours.from_now,
        conditions: [
          { bucket: ENV['AWS_S3_BUCKET_NAME_HOLLYWOOD'] },
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
end

