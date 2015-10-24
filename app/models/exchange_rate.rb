class ExchangeRate < ActiveRecord::Base
	belongs_to :currency_one, class_name: "Currency"
	belongs_to :currency_two, class_name: "Currency"
  belongs_to :account
end
