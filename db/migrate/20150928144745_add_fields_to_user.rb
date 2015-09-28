class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :is_support, :boolean, default: false
    add_column :users, :user_type, :string
  end
end
