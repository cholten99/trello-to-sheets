#!/home/dave/.rvm/rubies/ruby-2.1.1/bin/ruby

trello_key = "c59a7b019462975e99352ae108f6e153"
# trello_secret = 3677328fab544d1ae501402820b9d05bdc9564ab1a0afd50afd6b9bc7e5f503a
trello_token = "126acc110c3bd465fb044df5ca3f8164634d2fefc69a71f8cfcdcc8118e7644e"
drive_client_id = "654211656784-p3locaum2vk6d6i11o6jes9mfppllgb4.apps.googleusercontent.com"
drive_client_secret = "kc6HYPzkProbTsTpH0MrTr7T"

require "google/api_client"
require "google_drive"

=begin
# Authorizes with OAuth and gets an access token.
client = Google::APIClient.new
auth = client.authorization
auth.client_id = drive_client_id 
auth.client_secret = drive_client_secret 
auth.scope =
    "https://www.googleapis.com/auth/drive" +
    "https://spreadsheets.google.com/feeds/"
auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
print("2. Enter the authorization code shown in the page: ")
auth.code = $stdin.gets.chomp
auth.fetch_access_token!
access_token = auth.access_token
=end

# Creates a session.
session = GoogleDrive.login_with_oauth(access_token)

# Gets list of remote files.
for file in session.files
  p file.title
end
