class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.references :user, index: true
      t.references :account, index: true
      t.boolean :is_preferred, default: false

      t.timestamps null: false
    end
    add_foreign_key :user_accounts, :users
    add_foreign_key :user_accounts, :accounts
  end
end
