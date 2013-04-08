module UseUrnForParams
  extend ActiveSupport::Concern

  def to_param
    urn
  end
end
