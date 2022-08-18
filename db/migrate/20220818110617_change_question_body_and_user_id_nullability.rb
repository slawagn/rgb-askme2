class ChangeQuestionBodyAndUserIdNullability < ActiveRecord::Migration[7.0]
  def change
    change_column_null :questions, :body, false
    change_column_null :questions, :user_id, false
  end
end
