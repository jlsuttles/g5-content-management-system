class UserTable < TableCloth::Base
  column :username
  action {|user, h| h.link_to "Show", h.user_path(user) }
  action {|user, h| h.link_to "Edit", h.edit_user_path(user) }
  action {|user, h| h.link_to "Destroy", user, data: { confirm: "Are you sure?" }, method: :delete }
end
