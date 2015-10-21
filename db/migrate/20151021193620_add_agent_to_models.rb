class AddAgentToModels < ActiveRecord::Migration
  def change
    add_reference :users, :agent, index: true
    add_foreign_key :users, :agents
    add_reference :payments, :from_agent, index: true
    add_foreign_key :payments, :agents
    add_reference :payments, :to_agent, index: true
    add_foreign_key :payments, :agents
  end
end
