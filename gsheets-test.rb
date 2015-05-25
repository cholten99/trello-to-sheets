#!/home/dave/.rvm/rubies/ruby-2.1.1/bin/ruby

# google-drive-ruby : https://goo.gl/NO231
require "google/api_client"
require "google_drive"

client = Google::APIClient.new(:application_name => "trello-to-seets", :application_version => "0.1")
auth = client.authorization
auth.client_id = "654211656784-p3locaum2vk6d6i11o6jes9mfppllgb4.apps.googleusercontent.com"
auth.client_secret = "kc6HYPzkProbTsTpH0MrTr7T"
auth.scope = [
    "https://www.googleapis.com/auth/drive",
    "https://spreadsheets.google.com/feeds/"
]
auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"

# print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
# print("2. Enter the authorization code shown in the page: ")
# auth.code = $stdin.gets.chomp

file = File.open("sheets-auth-code.txt", "r")

auth.code = file.read

auth.fetch_access_token!
access_token = auth.access_token

# Creates a session.
session = GoogleDrive.login_with_oauth(access_token)

# Gets list of remote files.
for file in session.files
  p file.title
end
