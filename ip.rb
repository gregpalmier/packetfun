#!/usr/bin/env ruby
# ruby ip.rb <ip>

require 'awesome_print'
require 'shodan'
require 'pry'
require 'resolv'
require 'yaml'

shodan = YAML.load_file(File.join(File.dirname(__FILE__), 'shodan.yml'))
key = shodan['key']
api = Shodan::Shodan.new(key)

ip = ARGV.first
host = api.host(ip)
ap host
