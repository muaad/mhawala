class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :short_name
      t.string :country
      t.string :symbol

      t.timestamps null: false
    end
  end
end
