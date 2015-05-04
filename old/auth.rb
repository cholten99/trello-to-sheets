TRELLO_KEY = "c59a7b019462975e99352ae108f6e153"
TRELLO_TOKEN = "126acc110c3bd465fb044df5ca3f8164634d2fefc69a71f8cfcdcc8118e7644e"

def setup_trello()
  Trello.configure do |config|
    config.developer_public_key = TRELLO_KEY 
    config.member_token = TRELLO_TOKEN 
  end
end

DRIVE_API_VERSION = 'v2'
DRIVE_CREDENTIAL_STORE_FILE = "#{$0}-drive-oauth2.json"
DRIVE_DISCOVERY_CACHE = 'drive-discovery.cache'

# Handles authentication and loading of the drive API.
def setup_drive()

  client = Google::APIClient.new(:application_name => 'Trello to drive', :application_version => '1.0.0')

  # FileStorage stores auth credentials in a file, so they survive multiple runs
  # of the application. This avoids prompting the user for authorization every
  # time the access token expires, by remembering the refresh token.
  # Note: FileStorage is not suitable for multi-user applications.
  file_storage = Google::APIClient::FileStorage.new(DRIVE_CREDENTIAL_STORE_FILE)
  if file_storage.authorization.nil?
    client_secrets = Google::APIClient::ClientSecrets.load
    # The InstalledAppFlow is a helper class to handle the OAuth 2.0 installed
    # application flow, which ties in with FileStorage to store credentials
    # between runs.
    flow = Google::APIClient::InstalledAppFlow.new(
      :client_id => client_secrets.client_id,
      :client_secret => client_secrets.client_secret,
      :scope => ['https://www.googleapis.com/auth/drive', 'https://spreadsheets.google.com/feeds/']
    )
    client.authorization = flow.authorize(file_storage)
  else
    client.authorization = file_storage.authorization
  end

  drive = client.discovered_api('drive', DRIVE_API_VERSION)

  return client, drive 
end

