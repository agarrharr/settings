#!/usr/bin/ruby

title = ""
artist = ""
album = ""

counter = 1
file = File.new('nowplaying', 'r')
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

`terminal-notifier -message "Artist: #{artist}\nAlbum: #{album}" -title "#{title}"`
