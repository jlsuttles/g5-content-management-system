module AssociationToMethod
  extend ActiveSupport::Concern
  
  included do
    after_initialize :define_dynamic_association_methods
  end
  
  def define_dynamic_association_methods
    dynamic_association.each do |association|
      define_dynamic_association_method association
    end
  end
  
  def define_dynamic_association_method(association)
    define_singleton_method association.name.parameterize.underscore.to_sym, lambda { association }
  end
  
end