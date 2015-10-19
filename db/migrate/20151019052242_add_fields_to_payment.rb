class AddFieldsToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :channel, :string, default: "Hawala"
    add_column :payments, :withdrawn, :boolean, default: false
    add_reference :payments, :recorded_by, index: true
    add_foreign_key :payments, :users
    add_reference :payments, :withdrawn_by, index: true
    add_foreign_key :payments, :users
    add_column :payments, :withdrawn_at, :datetime
  end
end
