class DropTarget < ActiveRecord::Base
  belongs_to :web_template
  has_many :widgets, -> { order("widgets.display_order ASC") }
end
