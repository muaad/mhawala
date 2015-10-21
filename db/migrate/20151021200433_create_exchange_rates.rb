class CreateExchangeRates < ActiveRecord::Migration
  def change
    create_table :exchange_rates do |t|
      t.references :account, index: true
      t.string :currency_one
      t.string :currency_two
      t.float :buying
      t.float :selling
      t.string :city

      t.timestamps null: false
    end
    add_foreign_key :exchange_rates, :accounts
  end
end
