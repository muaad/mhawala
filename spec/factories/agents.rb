# == Schema Information
#
# Table name: agents
#
#  id         :integer          not null, primary key
#  name       :string
#  location   :string
#  city       :string
#  country    :string
#  latitude   :float
#  longitude  :float
#  account_id :integer
#  verified   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :agent do
    name "MyString"
location "MyString"
city "MyString"
country "MyString"
latitude 1.5
longitude 1.5
account nil
verified false
  end

end
