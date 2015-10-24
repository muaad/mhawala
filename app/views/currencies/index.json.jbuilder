json.array!(@currencies) do |currency|
  json.extract! currency, :id, :name, :short_name, :country, :symbol
  json.url currency_url(currency, format: :json)
end
