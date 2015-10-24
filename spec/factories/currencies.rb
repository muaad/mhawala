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

FactoryGirl.define do
  factory :currency do
    name "MyString"
short_name "MyString"
country "MyString"
symbol "MyString"
  end

end
