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

require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
