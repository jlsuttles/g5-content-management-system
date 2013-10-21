class DropTarget < ActiveRecord::Base
  belongs_to :web_template
  has_many :widgets, order: "display_order ASC"
end
