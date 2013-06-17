G5ClientHub.WebsiteTemplate = DS.Model.extend
  created_at: DS.attr("date"),
  updated_at: DS.attr("date"),
  disabled: DS.attr("boolean"),
  name: DS.attr("string"),
  slug: DS.attr("string"),
  template: DS.attr("boolean"),
  title: DS.attr("string"),
  website_id: DS.attr("number")
