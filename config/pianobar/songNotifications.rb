#!/usr/bin/ruby

require 'cgi'

File.open('pianobar/nowplaying', 'w') do |f2|
  f2.puts "hello"
end

trigger = ARGV.shift

if trigger == 'songstart'
  songinfo = {}
  STDIN.each_line { |line| songinfo.store(*line.chomp.split('=', 2))}

  `terminal-notifier -message "Artist: #{songinfo['artist']}\nAlbum: #{songinfo['album']}" -title "#{songinfo['title']}"`

  File.open('pianobar/nowplaying', 'w') do |f2|
    f2.puts "#{songinfo['title']}\nby #{songinfo['artist']}"
  end
end
