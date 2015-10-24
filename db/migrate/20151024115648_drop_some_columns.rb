class DropSomeColumns < ActiveRecord::Migration
  def change
  	remove_column :exchange_rates, :currency_one
  	remove_column :exchange_rates, :currency_two
  end
end
