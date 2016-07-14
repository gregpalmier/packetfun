#!/usr/bin/env ruby
require 'packetfu'
require 'pcaprub'
require 'pry'

# flag manipulation.

# http://www.rubydoc.info/github/todb/packetfu/PacketFu/Config
config = PacketFu::Config.new(PacketFu::Utils.whoami?(:iface=> 'en0')).config
# pkt = PacketFu::TCPPacket.new(:config => $config , :flavor => 'Linux')
pkt = PacketFu::TCPPacket.new(:config => $config)

pkt.ip_daddr = '192.168.1.100'
pkt.ip_saddr = '192.168.1.99'
pkt.tcp_dst = 80
pkt.tcp_urg = 1
pkt.tcp_flags[:urg] = 1
pkt.tcp_flags[:psh] = 1
binding.pry

# send out
10.times do
  pkt.to_w
  puts "sent PSH & URG flag from #{pkt.ip_saddr} to #{pkt.ip_daddr}"
end
