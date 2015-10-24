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

class Agent < ActiveRecord::Base
  belongs_to :account
end
