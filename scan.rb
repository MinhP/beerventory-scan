#!/usr/bin/env ruby
require 'json'
require 'net/http'

ENDPOINT = "http://localhost/api/checkout"
LOCATION = "SendGrid"

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
	entry['UPC'] = $stdin.gets
	entry['TS'] = Time.now.to_i
	entry['LOC'] = LOCATION

	post_entry entry
	puts "TRANSMITTED"
end
