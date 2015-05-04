#!/home/dave/.rvm/rubies/ruby-2.1.1/bin/ruby

# https://github.com/jeremytregunna/ruby-trello
require 'trello'

# https://github.com/google/google-api-ruby-client
# https://developers.google.com/drive/web/quickstart/quickstart-ruby
require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/file_storage'
require 'google/api_client/auth/installed_app'

# Stuff
require 'logger'
require 'json'
require './auth.rb'

def trello_test
  user = Trello::Member.find("daviddurant3")
  p user.full_name

  boards = Trello::Organization.find("piponline").boards
  boards.each do |board|
    puts "ID: #{board.id}, name #{board.name}"
  end
end

def sheet_test(client, drive)
  result = client.execute(
      :api_method => drive.files.list,
      :parameters => {})

  result.data.items.each do |item|
    p item.title
  end
end

if __FILE__ == $0
#  setup_trello()
#  trello_test
  client, drive = setup_drive()
  sheet_test(client, drive)
end
