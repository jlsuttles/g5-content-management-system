require "aws-sdk"

module StaticWebsite
  module Compiler
    class Javascript
      class Uploader
        attr_reader :from_paths, :s3, :bucket_name, :bucket_url, :uploaded_paths

        def initialize(from_paths, location_name)
          @from_paths = from_paths
          @s3 = AWS::S3.new(
            access_key_id: ENV["AWS_ACCESS_KEY_ID"],
            secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
          )
          location_name = location_name.to_s.underscore.upcase
          @bucket_name = ENV["AWS_S3_BUCKET_NAME_#{location_name}"]
          @bucket_url = ENV["AWS_S3_BUCKET_URL_#{location_name}"]
        end

        def compile
          @uploaded_paths = []
          from_paths.each do |from_path|
            s3_bucket_object(from_path).write(Pathname.new(from_path),
              acl: :public_read)
            @uploaded_paths << File.join(bucket_url.to_s, to_path(from_path).to_s)
          end
        end

        def s3_bucket
          @s3_bucket ||= if s3.buckets[bucket_name].exists?
            s3.buckets[bucket_name]
          else
            s3.buckets.create(bucket_name)
          end
        end

        def s3_bucket_object(from_path)
          s3_bucket.objects[to_path(from_path)]
        end

        def to_path(from_path)
          filename = File.basename(from_path)
          to_path = File.join("javascripts", filename)
        end
      end
    end
  end
end
