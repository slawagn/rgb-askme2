class RemoveHeaderColorFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :header_color, :integer
  end
end
