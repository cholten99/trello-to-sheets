import numpy as numpy
from datetime import date, datetime
from trello import TrelloClient
from card_plus import CardPlus

# Create connection to Trello
trello_client = TrelloClient(
    api_key = "daad4d77e580ebd5d2d522f439b07f74",
    api_secret = "c7a8b9ac48bb7074b92161f37f0ccaaf23ee8f165e234bccb86013dd0a28aa19",
    token = "00dc3572fd9d961e96966c4e2c983f196e69604f42fc9dca71f82484db9f6efd",
    token_secret = "129721ad1698d337826dcf66443f7e99"
)

# Get the board
board = trello_client.get_board("7R56bpzE")

# Get all the labels for the board
label_list = board.get_labels()

# Pull all the cards from the board using the basic Card object
card_list = board.all_cards()

# Initialise the list of the CardPlus objects which is a suclass of the base Card object that stores more data
card_plus_list = []

# Convert Card objects to CardPlus objects while adding extra data
todays_date = date.today()
for card in card_list:
  
  # Number of working days since card last updated
  last_updated_date = card.date_last_activity
  business_days_between = numpy.busday_count(last_updated_date.date(), todays_date)
  card.business_days_since_update = business_days_between

  # Organisation and registers
  card.organisation = "None"
  card.registers = []
  card.location_picker = False
  for card_label_id in card.idLabels:
    for board_label in label_list:
      if ((card_label_id == board_label.id) and (board_label.color == "green")):
        card.organisation = board_label.name
        break
      elif ((card_label_id == board_label.id) and (board_label.color == "black")):
        card.registers.append(board_label.name)
        break
      elif ((card_label_id == board_label.id) and (board_label.color == "sky")):
        card.location_picker = True
        break

  # Tokenise and store sections of description
  description = card.description
  line_list = description.split("\n")
  for line in line_list:
    if ": " not in line:
      continue
    else:
      parts = line.split(": ")
      setattr(card, parts[0], parts[1])


"""

# For testing
for card in card_list:
  print "Name : " + card.name
  print "Short URL : " + card.short_url
  print "Business_days_between : " + str(card.business_days_since_update)
  print "Organisation : " + card.organisation
  print "Registers : " + ", ".join(card.registers)
  print "Location picker : True" if (card.location_picker == True) else "Location picker : False"
  print "Attributes : " + ", ".join(card.__dict__.keys())
  print "+++++++"

"""