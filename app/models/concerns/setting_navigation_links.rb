module SettingNavigationLinks
  extend ActiveSupport::Concern

  included do
    has_many :web_templates,
      after_add: :update_setting_navigation,
      after_remove: :update_setting_navigation
  end

  def setting_navigations
    settings.find_or_initialize_by_name("navigations")
  end

  def web_page_templates_changed?
    web_page_templates.changed?
  end

  def update_setting_navigations
    setting_navigations.value = generate_setting_navigations
  end

  def generate_setting_navigations
    navigations = []
    # TODO: use decorator
    web_page_templates.each do |web_page_template|
      [] << {
        id: web_page_template.id,
        url: web_page_template.url,
        name: web_page_template.name,
        alt: web_page_template.alt,
        displayed: web_page_template.displayed
      }
    end
    navigations
  end
end
