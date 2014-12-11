#!/usr/bin/ruby

require 'cgi'

trigger = ARGV.shift

if trigger == 'songstart'
  songinfo = {}
  STDIN.each_line { |line| songinfo.store(*line.chomp.split('=', 2))}

  File.open('/Users/adamharris/.config/pianobar/nowplaying', 'w') do |f2|
    f2.puts "#{songinfo['artist']}\n#{songinfo['album']}\n#{songinfo['title']}"
  end

  system("ruby ~/.config/pianobar/pianobarFirebase.rb")
end
