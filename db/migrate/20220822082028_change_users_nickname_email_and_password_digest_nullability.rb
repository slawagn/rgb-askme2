class ChangeUsersNicknameEmailAndPasswordDigestNullability < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :name,            false
    change_column_null :users, :nickname,        false
    change_column_null :users, :email,           false
    change_column_null :users, :password_digest, false
  end
end
