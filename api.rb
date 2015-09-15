#!/usr/pkg/bin/ruby
require 'excon'
require 'json'

def streamer
  lambda do |chunk, remaining_bytes, total_bytes|
    stats = JSON.parse(chunk)  
    puts stats["blkio_stats"]["io_service_bytes_recursive"]
  end
end

connection = Excon.new('unix:///', socket: '/var/run/docker.sock')
connection.request(method: :get, path: "/containers/#{ARGV[0]}/stats", response_block: streamer)
