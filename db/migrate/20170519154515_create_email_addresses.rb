class CreateEmailAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :email_addresses do |t|
      t.string :email_address
      t.references :user, foreign_key: true
      t.boolean :primary

      t.timestamps
    end
  end
end
