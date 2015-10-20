json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :phone_number, :last_location
  json.url user_url(user, format: :json)
end
