class AddWithdrawalCurrencyToPayment < ActiveRecord::Migration
  def change
    add_reference :payments, :withdrawal_currency, index: true
    add_foreign_key :payments, :currencies
  end
end
