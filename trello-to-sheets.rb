#!/home/dave/.rvm/rubies/ruby-2.1.1/bin/ruby

# Trello stuff
# https://github.com/jeremytregunna/ruby-trello
require 'trello'

# General stuff
require 'logger'
require 'json'
require 'date'

# My stuff
require './auth.rb'

def trello_do

Create list of new class for board_stats (cards no due dates, cards no members, count per member, oldest card & age)
Create list for member_stats (over count for each member)

Remember to not count "Done" lists

Loop through everything updateing (emptying and replacing?) google XLS

# name, due date, created, last updated date, last updated by whom, members
card = Trello::Card.find("553f529aa1e32c73c3be6765")
puts "Name : " + card.name
puts "Due : " + card.due.strftime("%d/%m/%Y")
print "Members : "
card.members.each do |member|
  print member.full_name
  print ", " unless member == card.members.last
end
puts
puts "Created on : " + card.actions.last.date.strftime("%d/%m/%Y")
puts "Created by : " + card.actions.last.member_creator.full_name 
puts "Last updated on : " + card.actions.first.date.strftime("%d/%m/%Y")
puts "Last updated by : " + card.actions.first.member_creator.full_name
age = ((card.actions.first.date - card.actions.last.date).round / 86400).round.to_s
puts "Number of days old : " + age 
exit


  puts "1: Erase all worksheets\n\n"
  boards = Trello::Organization.find("piponline").boards
  boards.each do |board|
    puts "Board name : #{board.name}"

    board.lists.each do |list|
      puts "> List : #{list.name}"

      list.cards.each do |card|

        print ">> Card : "
# name, due date, created, last updated date, last updated by whom, members
        puts "#{card.name}"
        print "Due date : "

# puts card.attributes
# exit
        puts
      end

    end
    puts

  end
end

if __FILE__ == $0
  setup_trello
  trello_do
#  setup_drive
#  sheet_test(client, drive)
end
