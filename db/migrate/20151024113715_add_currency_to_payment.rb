class AddCurrencyToPayment < ActiveRecord::Migration
  def change
    add_reference :payments, :currency, index: true
    add_foreign_key :payments, :currencies
  end
end
