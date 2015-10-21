json.array!(@exchange_rates) do |exchange_rate|
  json.extract! exchange_rate, :id, :account_id, :currency_one, :currency_two, :buying, :selling, :city
  json.url exchange_rate_url(exchange_rate, format: :json)
end
