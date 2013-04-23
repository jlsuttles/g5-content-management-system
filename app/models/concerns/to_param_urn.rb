module ToParamUrn
  extend ActiveSupport::Concern

  def to_param
    urn
  end
end
