module AfterCreateUpdateUrn
  extend ActiveSupport::Concern

  included do
    after_create :update_urn
  end

  module ClassMethods
    def set_urn_prefix(prefix)
      @urn_prefix = prefix
    end

    def urn_prefix
      @urn_prefix
    end
  end

  private

  def update_urn
    update_attributes(urn: new_urn)
  end

  def hashed_id
    "#{self.created_at.to_i}#{self.id}".to_i.to_s(36)
  end

  def new_urn
    "#{self.class.urn_prefix}-#{hashed_id}-#{parameterized_name}"
  end

  def parameterized_name
    name.try(:parameterize)
  end
end
