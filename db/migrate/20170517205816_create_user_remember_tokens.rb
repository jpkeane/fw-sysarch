class CreateUserRememberTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :user_remember_tokens do |t|
      t.references :user, foreign_key: true
      t.string :remember_digest, null: false

      t.timestamps
    end
  end
end
