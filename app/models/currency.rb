# == Schema Information
#
# Table name: currencies
#
#  id         :integer          not null, primary key
#  name       :string
#  short_name :string
#  country    :string
#  symbol     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Currency < ActiveRecord::Base
	has_many :payments

	def exchange amount, to_currency_id
		to_currency = Currency.find(to_currency_id)
		exchange_rate = ExchangeRate.find_by(currency_one: self, currency_two: to_currency)
		if !exchange_rate.nil?
			Money.add_rate(self.short_name, to_currency.short_name, exchange_rate.selling)
			m = Money.new(amount, self.short_name).exchange_to(to_currency.short_name)
			response = "#{amount} #{name} in #{to_currency.name} is #{m.fractional} at the exchange rate of #{exchange_rate.selling}"
		else
			response = "You haven't set the exchange rate for #{name} - #{to_currency.name}."
		end
		response
	end
end
