#!/usr/bin/env ruby
# ruby host.rb <hostname>

require 'awesome_print'
require 'shodan'
require 'pry'
require 'resolv'
require 'yaml'

shodan = YAML.load_file(File.join(File.dirname(__FILE__), 'shodan.yml'))
key = shodan['key']
api = Shodan::Shodan.new(key)

hostname = ARGV.first
ip_hostname = Resolv.getaddress(hostname)
host = api.host(ip_hostname)
ap host
