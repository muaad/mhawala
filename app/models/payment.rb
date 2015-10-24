class Payment < ActiveRecord::Base
	scope :created_between, lambda {|start_date, end_date| where("created_at >= ? AND created_at <= ?", start_date, end_date )}
	scope :last_month, lambda { where("created_at >= ? and created_at <= ?", Time.now.beginning_of_month - 1.month, (Time.now.beginning_of_month - 1.month).end_of_month )}		
	scope :current_month, lambda { where("created_at >= ? and created_at <= ?", Time.now.beginning_of_month, Time.now.end_of_month)}
	scope :today, lambda { where("created_at >= ? and created_at <= ?", Time.now.beginning_of_day, Time.now.end_of_day)}
	scope :yesterday, lambda { where("created_at >= ? and created_at <= ?", Time.now.beginning_of_day - 1.day, Time.now.end_of_day - 1.day)}
	scope :this_week, lambda { where("created_at >= ? and created_at <= ?", Time.now.beginning_of_week, Time.now.end_of_week)}
	scope :last_week, lambda { where("created_at >= ? and created_at <= ?", Time.now.beginning_of_week - 7.days, Time.now.end_of_week - 7.days)}
	scope :months_ago, lambda { |count| where("created_at >= ? AND created_at <= ?", Time.now.beginning_of_month - count.months, (Time.now.beginning_of_month - count.months).end_of_month)}
	
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  belongs_to :recorded_by, class_name: "User"
  belongs_to :withdrawn_by, class_name: "User"
  belongs_to :from_agent, class_name: "Agent"
  belongs_to :to_agent, class_name: "Agent"
  belongs_to :account
  belongs_to :currency
end
