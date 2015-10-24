class ReportsController < ApplicationController
  def dashboard
  end

  def remittances
  end

  def agents
  end

  def staff
  end

  # def index
  # 	@last_ten_images = Message.where(direction: "IN", message_type: "Image").order(id: :desc).first(10)

  # 	@last_six_hours_in = Message.where(direction: "IN").group_by_hour(:created_at, format: "%l %P", range: 6.hours.ago..Time.now, time_zone: account.timezone).count
  # 	@last_six_hours_out = Message.where(direction: "OUT").group_by_hour(:created_at, format: "%l %P", range: 6.hours.ago..Time.now, time_zone: account.timezone).count

  # 	@last_six_hours_in_count = Message.incoming.created_between(6.hours.ago, Time.now).count
  # 	@prev_six_hours_in_count = Message.incoming.created_between(12.hours.ago, 6.hours.ago).count

  # 	@last_six_hours_out_count = Message.outgoing.created_between(6.hours.ago, Time.now).count
  # 	@prev_six_hours_out_count = Message.outgoing.created_between(12.hours.ago, 6.hours.ago).count

  # 	@last_six_hours_contacts_count = Contact.created_between(6.hours.ago, Time.now).count
  # 	@prev_six_hours_contacts_count = Contact.created_between(12.hours.ago, 6.hours.ago).count
  	
  	
  # 	@top_five_contacts = popular_contacts(6.hours.ago, Time.now, 5)				
  # 	@top_five_groups = Group.joins(:messages).where('messages.direction=?','IN').group('messages.group_id').order("count(messages.group_id) desc").first(5)


  # 	# @top_five_words = Token.joins(:occurrences).where('occurrences.created_at >= ? and occurrences.created_at <= ?', Time.now.beginning_of_day, Time.now).group('occurrences.token_id').order("count(occurrences.token_id) desc").count('occurrences.token_id').first(10)
  # 	# total = @top_five_words.collect { |w| w.last }.inject { |sum, x| sum + x }
  # 	# @trends = @top_five_words.collect { |t| [Token.find(t.first).word, (t.last.to_f / 10 * 100).to_f] }	

  # 	@today_response_times = response_times Time.now.beginning_of_day, Time.now
  # 	@yesterday_response_times = response_times 2.days.ago, 1.day.ago
  # end

  # def activity
  # 	@activity = Message.created_between(10.days.ago, Time.now).group_by_hour(:created_at, format: "%s").count
  # 	render json: @activity
  # end

  # def locations
  # 	@locations = Location.all
  # 	@country = Geoip.get_country request.remote_ip
  # end

  # def messages
  # 	if params[:period] == "Month" || !params.has_key?(:period)
  # 		@period = params[:month].to_i.month.ago.strftime('%b %Y')

  # 		@incoming = Message.created_between(params[:month].to_i.months.ago.beginning_of_month, params[:month].to_i.months.ago.end_of_month).where(direction: "IN").group_by_day_of_month(:created_at, time_zone: account.timezone).count
  # 		@outgoing = Message.created_between(params[:month].to_i.months.ago.beginning_of_month, params[:month].to_i.months.ago.end_of_month).where(direction: "OUT").group_by_day_of_month(:created_at, time_zone: account.timezone).count			
  		
  # 		@current_incoming = Message.created_between(params[:month].to_i.months.ago.beginning_of_month, params[:month].to_i.months.ago.end_of_month).incoming.count
  # 		@current_outgoing = Message.created_between(params[:month].to_i.months.ago.beginning_of_month, params[:month].to_i.months.ago.end_of_month).outgoing.count

  # 		@prev_incoming = Message.created_between((params[:month].to_i + 1).months.ago.beginning_of_month, (params[:month].to_i + 1).months.ago.end_of_month).incoming.count
  # 		@prev_outgoing = Message.created_between((params[:month].to_i + 1).months.ago.beginning_of_month, (params[:month].to_i + 1).months.ago.end_of_month).outgoing.count
  # 	elsif params[:period] == "Day"
  # 		@period = params[:day].to_i.day.ago.strftime("%b %-d, %Y")

  # 		@incoming = Message.created_between(params[:day].to_i.days.ago.beginning_of_day, params[:day].to_i.days.ago.end_of_day).where(direction: "IN").group_by_hour_of_day(:created_at, format: "%l %P", time_zone: account.timezone).count
  # 		@outgoing = Message.created_between(params[:day].to_i.days.ago.beginning_of_day, params[:day].to_i.days.ago.end_of_day).where(direction: "OUT").group_by_hour_of_day(:created_at, format: "%l %P", time_zone: account.timezone).count			
  		
  # 		@current_incoming = Message.created_between(params[:day].to_i.days.ago.beginning_of_day, params[:day].to_i.days.ago.end_of_day).incoming.count
  # 		@current_outgoing = Message.created_between(params[:day].to_i.days.ago.beginning_of_day, params[:day].to_i.days.ago.end_of_day).outgoing.count

  # 		@prev_incoming = Message.created_between((params[:day].to_i + 1).days.ago.beginning_of_day, (params[:day].to_i + 1).days.ago.end_of_day).incoming.count
  # 		@prev_outgoing = Message.created_between((params[:day].to_i + 1).days.ago.beginning_of_day, (params[:day].to_i + 1).days.ago.end_of_day).outgoing.count
  # 	elsif params[:period] == "Week"
  # 		@period = "#{params[:week].to_i.week.ago.beginning_of_week.strftime('%b %-d')} to #{params[:week].to_i.week.ago.end_of_week.strftime('%b %-d')}"

  # 		@incoming = Message.created_between(params[:week].to_i.weeks.ago.beginning_of_week, params[:week].to_i.weeks.ago.end_of_week).where(direction: "IN").group_by_day_of_week(:created_at, format: "%a", time_zone: account.timezone).count
  # 		@outgoing = Message.created_between(params[:week].to_i.weeks.ago.beginning_of_week, params[:week].to_i.weeks.ago.end_of_week).where(direction: "OUT").group_by_day_of_week(:created_at, format: "%a", time_zone: account.timezone).count			
  		
  # 		@current_incoming = Message.created_between(params[:week].to_i.weeks.ago.beginning_of_week, params[:week].to_i.weeks.ago.end_of_week).incoming.count
  # 		@current_outgoing = Message.created_between(params[:week].to_i.weeks.ago.beginning_of_week, params[:week].to_i.weeks.ago.end_of_week).outgoing.count

  # 		@prev_incoming = Message.created_between((params[:week].to_i + 1).weeks.ago.beginning_of_week, (params[:week].to_i + 1).weeks.ago.end_of_week).incoming.count
  # 		@prev_outgoing = Message.created_between((params[:week].to_i + 1).weeks.ago.beginning_of_week, (params[:week].to_i + 1).weeks.ago.end_of_week).outgoing.count
  # 	end
  # end

  # def contacts
  # 	if params[:period] == "Day"
  # 		@period = Time.now.strftime("%b %-d, %Y")

  # 		@top_contacts = popular_contacts(Time.now.beginning_of_day, Time.now.end_of_day, 20)
  # 	elsif params[:period] == "Week"
  # 		week_start = Time.now.beginning_of_week
  # 		week_end = Time.now.end_of_week

  # 		@period = "#{week_start.strftime('%b %-d')} to #{week_end.strftime('%b %-d')}"
  # 		@top_contacts = popular_contacts(Time.now.beginning_of_week, Time.now.end_of_day, 20)
  # 	else
  # 		@period = Time.now.strftime('%b %Y')
  # 		@top_contacts = popular_contacts(Time.now.beginning_of_month, Time.now.end_of_day, 20)
  # 	end

  # end

  # def online_times
  # 	if params[:time_range]
  # 		range = params[:time_range]
  # 		if range == "month"
  # 			@periodly = "Monthly"
  # 			@period = Time.now.strftime('%b %Y')
  # 			@online_times = OnlineTime.all.group_by_hour(:last_seen, range: Time.now.beginning_of_month.midnight..Time.now).count
  # 		elsif range == "week"
  # 			@periodly = "Weekly"
  # 			@period = "This week - #{Time.now.beginning_of_week.strftime("%m/%d/%Y")} - #{Time.now.strftime("%m/%d/%Y")}"
  # 			@online_times = OnlineTime.all.group_by_hour(:last_seen, range: Time.now.beginning_of_week.midnight..Time.now).count
  # 		elsif range == "day"
  # 			@periodly = "Daily"
  # 			@period = "Today - #{Time.now.strftime("%m/%d/%Y")}"
  # 			@online_times = OnlineTime.all.group_by_hour(:last_seen, range: 6.hours.ago..Time.now).count
  # 		else
  # 			redirect_to reports_path
  # 		end
  # 	else
  # 		params[:time_range] = "day"
  # 		@periodly = "Daily"
  # 		@period = "Today"
  # 		@online_times = OnlineTime.all.group_by_hour(:last_seen, range: 6.hours.ago..Time.now).count
  # 	end
  # end

  # def response_times from, to
  # 	time_differences = []
  # 	Conversation.where('created_at >= ? and created_at <= ?', from, to).each do |convo|
  # 		incoming = convo.messages.where(direction: "IN").first
  # 		outgoing = convo.messages.where(direction: "OUT").first
  # 		if !incoming.nil? && !outgoing.nil? && outgoing.auto_responder.nil?
  # 			time_differences << outgoing.created_at - incoming.created_at
  # 		end
  # 	end
  # 	if time_differences.length > 0
  # 		return (((time_differences.sum / time_differences.length).round(2)) / 60).round(2)
  # 	else
  # 		return 0.0
  # 	end
  # end

  # def agents
  # 	@users = UserAccount.where(account: account).map { |ua| ua.user }
  # end

  # def traction
  # 	ActsAsTenant.current_tenant = nil
  # 	@incoming_messages = Message.created_between(6.months.ago, Time.now).incoming.personal.group_by_month(:created_at, format: '%b %Y').count
  # 	@outgoing_messages = Message.created_between(6.months.ago, Time.now).outgoing.personal.group_by_month(:created_at, format: '%b %Y').count

  # 	@accounts_created = Account.created_between(6.months.ago, Time.now).group_by_month(:created_at, format: '%Y-%m').count
  # 	@accounts = Account.count
  # 	@active_accounts = Account.active.count
  # 	@messages = Message.count

  # 	broadcast_count = 0
  # 	Broadcast.all.each do |b|
  # 		if !b.distribution_list.nil?
  # 			broadcast_count += b.distribution_list.contacts.count
  # 		end
  # 	end
  # 	@messages += broadcast_count

  # 	@contacts = Contact.count

  # 	@media = Message.images.count + Message.videos.count
  # end

  # def account_activation
  # 	@account  = Account.find(params[:id])
  # 	@cc = get_country_code
  # 	c = Carrier.instance
  # 	@carriers = c.carriers
  # end

  # def create_account
  # 	# account = Account.create!(name: params[:name], phone_number: params[:phone_number], whatsapp_password: params[:whatsapp_password], setup: params[:setup])
  # 	redirect_to account_activation_path(account), notice: "Account successfully created!"
  # end

  # def users
  # 	@users = User.all.order(created_at: :desc)
  # end

  # private

  # def popular_contacts start_time, end_time, amount=5
  # 	Contact.joins(:messages).where('messages.direction=? and messages.group_id is ? and messages.created_at >= ? and messages.created_at <= ?','IN', nil, start_time, end_time).group('messages.contact_id').order("count(messages.contact_id) desc").first(amount)
  # end
end
