import numpy as numpy
from datetime import date, datetime
from trello import TrelloClient

trello_client = TrelloClient(
    api_key = "daad4d77e580ebd5d2d522f439b07f74",
    api_secret = "c7a8b9ac48bb7074b92161f37f0ccaaf23ee8f165e234bccb86013dd0a28aa19",
    token = "00dc3572fd9d961e96966c4e2c983f196e69604f42fc9dca71f82484db9f6efd",
    token_secret = "129721ad1698d337826dcf66443f7e99"
)

card_list = trello_client.get_board("7R56bpzE").all_cards()

todays_date = date.today()

for card in card_list:
  last_updated_date = card.date_last_activity
  business_days_between = numpy.busday_count(last_updated_date, todays_date)
  print "Name : " + card.name
  print "Business_days_between : " + str(business_days_between)
  print "+++++++"

