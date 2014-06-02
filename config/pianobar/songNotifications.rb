#!/usr/bin/ruby

require 'cgi'

trigger = ARGV.shift

if trigger == 'songstart'
  songinfo = {}
  STDIN.each_line { |line| songinfo.store(*line.chomp.split('=', 2))}

  `terminal-notifier -message "Artist: #{songinfo['artist']}\nAlbum: #{songinfo['album']}" -title "#{songinfo['title']}"`
end
