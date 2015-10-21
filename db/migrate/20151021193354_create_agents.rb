class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :name
      t.string :location
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude
      t.references :account, index: true
      t.boolean :verified

      t.timestamps null: false
    end
    add_foreign_key :agents, :accounts
  end
end
