# == Schema Information
#
# Table name: exchange_rates
#
#  id              :integer          not null, primary key
#  account_id      :integer
#  buying          :float
#  selling         :float
#  city            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  currency_one_id :integer
#  currency_two_id :integer
#

class ExchangeRate < ActiveRecord::Base
	belongs_to :currency_one, class_name: "Currency"
	belongs_to :currency_two, class_name: "Currency"
  belongs_to :account
end
