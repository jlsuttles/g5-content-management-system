class RemoveDefaultsForLocationColors < ActiveRecord::Migration
  def up
    change_column_default :locations, :primary_color, nil
    change_column_default :locations, :secondary_color, nil
  end

  def down
    change_column_default :locations, :secondary_color, "#ffffff"
    change_column_default :locations, :primary_color, "#000000"
  end
end
