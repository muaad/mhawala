class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.boolean :active
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :accounts, :users
  end
end
