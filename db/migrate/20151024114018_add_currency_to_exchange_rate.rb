class AddCurrencyToExchangeRate < ActiveRecord::Migration
  def change
    add_reference :exchange_rates, :currency_one, index: true
    add_foreign_key :exchange_rates, :currencies
    add_reference :exchange_rates, :currency_two, index: true
    add_foreign_key :exchange_rates, :currencies
  end
end
