#/usr/bin/env ruby

require 'awesome_print'
require 'pry'
require 'yaml'
require 'csv'
require 'ipaddr'
require 'elasticsearch'
require 'net/ftp'
require 'resolv'

# add an ordered approach to these IP addresses
1.times do
  ip_addr = IPAddr.new(rand(2**32),Socket::AF_INET)
  # anon allowed ip for test:
  # name = 'speedtest.tele2.net'
  # ip_addr = Resolv.getaddress name
  # anon disallowed ip:
  # ip_addr = '85.125.186.241'
  begin
    ftp = Net::FTP.new(ip_addr)
  rescue Exception => e
    puts "no FTP available for #{ip_addr}"
    next
  end

  begin
    ftp.login
  rescue Exception => e
    puts "Fail on #{ip_addr}: #{ftp.last_response_code}"
    next
  end

  result = {}
    if ftp.last_response_code.to_i < 299
      files = ftp.nlst.join(' ')
      # binding.pry
      result['ip_addr'] = ip_addr
      result['last_response_code'] = ftp.last_response_code
      result['last_response'] = ftp.last_response.delete("\n")
      result['status'] = ftp.status.delete("\n")
      result['welcome'] = ftp.welcome.delete("\n")
      result['files'] = files
    else
      result['ip_addr'] = ip_addr
      result['last_response_code'] = ftp.last_response_code
      result['last_response'] = ftp.last_response.delete("\n")
  end

  ap result
  result['published_at'] = Time.now.utc.iso8601
  es = Elasticsearch::Client.new host: 'localhost:9200', log: true
  es.index index: 'ftp',
    type: 'random',
    body: result

  unless ftp.closed?
    ftp.close
  end

end
