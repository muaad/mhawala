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

FactoryGirl.define do
  factory :exchange_rate do
    account nil
currency_one "MyString"
currency_two "MyString"
buying 1.5
selling 1.5
city "MyString"
  end

end
