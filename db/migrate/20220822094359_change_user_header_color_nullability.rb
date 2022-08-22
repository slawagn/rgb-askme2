class ChangeUserHeaderColorNullability < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :header_color, false
  end
end
