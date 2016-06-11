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
result = api.search(term)
CSV.open("#{term}.csv", 'w') do |csv|
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
