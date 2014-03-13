class WebsiteTemplateSerializer < WebTemplateSerializer
  embed :ids, include: true

  has_one  :web_layout
  has_one  :web_theme

  has_many :head_widgets
  has_many :logo_widgets
  has_many :btn_widgets
  has_many :nav_widgets
  has_many :aside_before_widgets
  has_many :aside_after_widgets
  has_many :footer_widgets
end
