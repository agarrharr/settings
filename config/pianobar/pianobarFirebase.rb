#!/usr/bin/ruby

require 'cgi'
require 'firebase'

title = ""
artist = ""
album = ""

flag = ARGV[0]

counter = 1
file = File.new('/Users/adamharris/.config/pianobar/nowplaying', 'r')
while (line = file.gets)
  if counter == 1
    artist = line
  end
  if counter == 2
    album = line
  end
  if counter == 3
    title = line
  end
  counter = counter + 1
end

base_uri = 'https://blazing-fire-5020.firebaseio.com/'
system("ruby ~/.pianobarKey.rb") # secret_key = ''
firebase = Firebase::Client.new(base_uri, secret_key)
firebase.set("currentSong", { :artist => artist, :title => title, :album => album})
