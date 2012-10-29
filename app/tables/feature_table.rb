class FeatureTable < TableCloth::Base
  column :name
  action {|feature, h| h.link_to "Show", h.feature_path(feature) }
  action {|feature, h| h.link_to "Edit", h.edit_feature_path(feature) }
  action {|feature, h| h.link_to "Destroy", feature, data: { confirm: "Are you sure?" }, method: :delete }
end
