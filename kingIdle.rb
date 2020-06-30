# 							King Idle by WSINTRA
# 					June 2020 OpenSource - Feel free to copy/change

# Created as a way to ping my heroku free servers at frequent times
# Can be run from an always on server or a rasberry pi or a linux machine 

# Simple script to run in the background, 
# create a new url you want with new_url = Wake_me.new(some_url_string)
# don't forget to set its state to unidle

##TODO : Build out the script so it can accept incoming commands
# maybe convert it into a rails API that stores the url's in a DB
#############################################################
require 'net/ping'
# Use this method for making sure time is good for integers
class Integer
   def seconds
      return self
   end
   def minutes
      return self * 60
   end
   def hours
      return self * 3600
   end
   def days
      return self * 86400
   end
end

class Wake_me
	def initialize(url_string)
		@url_address = url_string
		@idle = true
	end

	def get_url
		return @url_address
	end

	def get_idle_state
		return @idle
	end

	def unidle
		@idle = false
	end

	def idle
		@idle = true
	end
end

drum = "https://infinite-tundra-44498.herokuapp.com/api/v1/drumkits"
drum_url = Wake_me.new(drum)
drum_url.unidle

list_of_url_to_wake = [
	{
		'url' => drum_url.get_url, 
		'idle'=> drum_url.get_idle_state
	},
]

def beginPings(list_of_urls)
	for remote in list_of_urls
		p1 = Net::Ping::HTTP.new(remote['url'])
		if (p1.ping?) 
		    puts "Pinging: " + remote['url']
		end
	end
end

while(true)
	beginPings(list_of_urls_to_wake)
	sleep(35.minutes)
end
