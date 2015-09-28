json.array!(@payments) do |payment|
  json.extract! payment, :id, :sender_id, :recipient_id, :amount, :reference_number, :transaction_number, :account_id, :sent
  json.url payment_url(payment, format: :json)
end
