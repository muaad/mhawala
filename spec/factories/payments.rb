# == Schema Information
#
# Table name: payments
#
#  id                 :integer          not null, primary key
#  sender_id          :integer
#  recipient_id       :integer
#  amount             :float
#  reference_number   :string
#  transaction_number :string
#  account_id         :integer
#  sent               :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  channel            :string           default("Hawala")
#  withdrawn          :boolean          default(FALSE)
#  recorded_by_id     :integer
#  withdrawn_by_id    :integer
#  withdrawn_at       :datetime
#  sent_from          :string
#  sent_to            :string
#  from_agent_id      :integer
#  to_agent_id        :integer
#  currency_id        :integer
#

FactoryGirl.define do
  factory :payment do
    sender nil
recipient nil
amount 1.5
reference_number "MyString"
transaction_number "MyString"
account nil
sent false
  end

end
