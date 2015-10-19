module ApplicationHelper
	def time_formater timestamp
		if !timestamp.nil?
			# zone = account.timezone
			localtime = timestamp#.in_time_zone(zone)
			if !localtime.nil?
				if localtime.today?
					localtime.strftime('%l:%M %p')
				else
					if Time.now.year == localtime.year
						localtime.strftime('%d %b %l:%M %p')
					else
						localtime.strftime('%d %b %Y %l:%M %p')
					end	
				end
			end
		end
	end
end
