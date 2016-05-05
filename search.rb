#!/usr/bin/env ruby

# ruby search.rb <term>

require 'awesome_print'
require 'shodan'
require 'pry'
require 'yaml'

shodan = YAML.load_file(File.join(File.dirname(__FILE__), 'shodan.yml'))
api = Shodan::Shodan.new(shodan['key'])

term = ARGV.first
result = api.search(term)
# binding.pry
result['matches'].each do |host|
  puts "IP: #{host['ip_str']}"
  host['hostnames'].each { |x| puts x }
end
