#!/usr/bin/ruby

title = ""
artist = ""
album = ""

flag = ARGV[0]

counter = 1
file = File.new('/Users/aharris88/.config/pianobar/nowplaying', 'r')
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

if flag == "--notification" || flag == "-n"
  `terminal-notifier -message "Artist: #{artist}\rAlbum: #{album}" -title "#{title}"`
else
  puts "Song: #{title}\rArtist: #{artist}\rAlbum: #{album}"
end
