class AddPriorityToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :priority, :integer
  end
end
