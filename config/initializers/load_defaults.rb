case Client.first.vertical

when 'Assisted-Living'
  default_template = 'website_defaults_assisted_living.yml'

when 'Self-Storage'
  default_template = 'website_defaults_self_storage.yml'

when 'Apartments'
  default_template = 'website_defaults_apartments.yml'

else
  default_template = 'defaults.yml'
end

DEFAULTS = YAML.load_file("#{Rails.root}/config/#{default_template}")
