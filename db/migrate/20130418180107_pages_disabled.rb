class PagesDisabled < ActiveRecord::Migration
  def change
    add_column :pages, :disabled, :boolean
  end
end
