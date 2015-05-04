#!/home/dave/.rvm/rubies/ruby-2.1.1/bin/ruby

# https://github.com/jeremytregunna/ruby-trello
require 'trello'

# Stuff
require 'logger'
require 'json'
require './auth.rb'

def trello_do
  puts "1: Erase all worksheets\n\n"
  boards = Trello::Organization.find("piponline").boards
  boards.each do |board|
    puts "ID: #{board.id}, name #{board.name}"
  end
end

if __FILE__ == $0
  setup_trello
  trello_do
#  setup_drive
#  sheet_test(client, drive)
end
