#!/usr/bin/env ruby

# ruby search.rb <term>

require 'awesome_print'
require 'shodan'
require 'pry'
require 'yaml'
require 'csv'

shodan = YAML.load_file(File.join(File.dirname(__FILE__), 'shodan.yml'))
api = Shodan::Shodan.new(shodan['key'])

term = ARGV.first
# paginate?
begin
  result = api.search(term)
rescue Exception => e
  puts 'Something went wrong!'
  puts e
end
puts "#{result['total']} results found!"
binding.pry
CSV.open("#{term}.csv", 'a+') do |csv|
  csv << ['hostnames', 'ip_str', 'ports']
  result['matches'].each do |host|
    h = api.host(host['ip_str'])
    hosts = []
    unless h['hostnames'].empty?
      hosts << h['hostnames']
    else
      hosts = ['None']
    end
    csv << [ hosts.join(','), h['ip_str'], h['ports'].join(',')]
    # don't get throttled?
    sleep 1
  end
end
