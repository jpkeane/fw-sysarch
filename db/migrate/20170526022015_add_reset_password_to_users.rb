class AddResetPasswordToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_reset_token, :string
    add_column :users, :password_reset_token_at, :datetime
  end
end
