# Navigation Widget

## How does it work at a high level?

- Website is responsible for creating & updating website setting
- When a web template name changes, website is told to update website setting
- When a web template status changes, website is told to update website setting (not yet implemented)
- Website setting is responsible for updating widget settings
- Website setting is used as the base, and the widget settings are merged into it

## Where is it implemented?

- `app/models/website.rb`
- `app/models/concerns/has_setting_navigation.rb`
- `app/models/web_template.rb`
- `app/models/concerns/after_update_set_setting_navigation.rb`

```ruby
class Website < ActiveRecord::Base
  include HasSettingNavigation
end

class WebTemplate < ActiveRecord::Base
  # TODO: rename more better
  # include AfterUpdateSetSettingNavigation
  inlcude UpdateWebsiteSettingNavigation
end

class Setting < ActiveRecord::Base
  include SettingNavigation
end
```
