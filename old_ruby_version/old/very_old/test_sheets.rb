#!/home/dave/.rvm/rubies/ruby-2.1.1/bin/ruby

require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/file_storage'
require 'google/api_client/auth/installed_app'
require 'logger'
require 'json'

log_file = File.open('trello-to-sheets.log', 'a+')
log_file.sync = true
logger = Logger.new(log_file)
logger.level = Logger::DEBUG

def remote_dir(client, drive)
  result = client.execute(
      :api_method => drive.files.list,
      :parameters => {})

  result.data.items.each do |item|
    p item.title
  end

end

if __FILE__ == $0
  client, drive = setup()
  remote_dir(client, drive)
end
