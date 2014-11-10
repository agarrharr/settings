#!/usr/bin/ruby

require 'cgi'
require 'firebase'

base_uri = 'https://blazing-fire-5020.firebaseio.com/'
firebase = Firebase::Client.new(base_uri)
firebase.push("songs", { :artist => "Adam"})
