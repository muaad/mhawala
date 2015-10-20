class AddLocationDetailsToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :sent_from, :string
    add_column :payments, :sent_to, :string
  end
end
