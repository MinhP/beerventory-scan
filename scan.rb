#!/usr/bin/env ruby
require 'json'
require 'net/http'

ENDPOINT = "http://107.170.201.151:4040/checkout"
LOCATION = 2

def post_entry (entry = {})
	uri = URI.parse(URI::escape(ENDPOINT))
	headers={'content-type'=>'applications/json'}
	request = Net::HTTP::Post.new(uri.request_uri, headers)
	request.body = entry
	Net::HTTP.new(uri.host,uri.port).start{|http| http.request(request)}    
end 

loop do
	entry = {}
	puts "READY"
	entry['upc'] = $stdin.gets.chomp
	entry['timestamp'] = Time.now.to_i
	entry['location'] = LOCATION

	post_entry entry.to_json
	puts "TRANSMITTED"
end
