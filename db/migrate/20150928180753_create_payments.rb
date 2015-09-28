class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :sender, index: true
      t.references :recipient, index: true
      t.float :amount
      t.string :reference_number
      t.string :transaction_number
      t.references :account, index: true
      t.boolean :sent, default: false

      t.timestamps null: false
    end
    add_foreign_key :payments, :senders
    add_foreign_key :payments, :recipients
    add_foreign_key :payments, :accounts
  end
end
