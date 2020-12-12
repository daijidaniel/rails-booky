class AddAuthLevelToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :auth_level, :integer, default: 0
  end
end
