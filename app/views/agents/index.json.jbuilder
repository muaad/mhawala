json.array!(@agents) do |agent|
  json.extract! agent, :id, :name, :location, :city, :country, :latitude, :longitude, :account_id, :verified
  json.url agent_url(agent, format: :json)
end
