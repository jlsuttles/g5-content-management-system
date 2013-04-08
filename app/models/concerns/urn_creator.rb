module UrnCreator
  extend ActiveSupport::Concern

  included do
    after_create :create_urn
  end

  module ClassMethods
    def set_urn_prefix(prefix)
      @@urn_prefix = prefix
    end

    def urn_prefix
      @@urn_prefix
    end
  end

  def create_urn
    update_attributes(urn: "#{self.class.urn_prefix}-#{id}-#{name.parameterize}")
  end
end
