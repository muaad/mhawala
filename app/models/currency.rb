class Currency < ActiveRecord::Base
	has_many :payments
end
