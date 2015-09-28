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
