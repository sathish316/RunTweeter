require 'open-uri'
require 'rubygems'
require 'json'

timeline = open("http://api.twitter.com/1/statuses/user_timeline.json?screen_name=#{ARGV[0]}", 'UserAgent' => 'RubyWget').read
tweets = JSON.parse(timeline).map {|tweet| tweet['text']}
distance = tweets.inject(0) do |distance,tweet|
	tweet.scan(/(\d+\.?\d*)\s?(k|K)/) { distance += $1.to_f if $1.to_f < 100 }
	distance
end
puts "You've run #{distance} K so far. Keep running..."
