case Client.first.vertical

when 'Assisted-Living'
  default_template = 'defaults_sl.yml'

when 'Self-Storage'
  default_template = 'defaults_ss.yml'

when 'Apartments'
  default_template = 'defaults_mf.yml'

else
  default_template = 'defaults.yml'
end

DEFAULTS = YAML.load_file("#{Rails.root}/config/#{default_template}")
