#!/usr/bin/env ruby
require 'packetfu'
require 'pcaprub'
require 'pry'

# http://www.rubydoc.info/github/todb/packetfu/PacketFu/Config
config = PacketFu::Config.new(PacketFu::Utils.whoami?(:iface=> 'en0')).config
# pkt = PacketFu::TCPPacket.new(:config => $config , :flavor => 'Linux')
pkt = PacketFu::TCPPacket.new(:config => $config)

pkt.ip_saddr = '2.2.2.2'
pkt.ip_daddr = '192.168.1.15'

# binding.pry

# send out
10.times do
  pkt.to_w
  puts 'sent'
  sleep 1
end
