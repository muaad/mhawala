# == Schema Information
#
# Table name: user_accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  account_id   :integer
#  is_preferred :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class UserAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
end
