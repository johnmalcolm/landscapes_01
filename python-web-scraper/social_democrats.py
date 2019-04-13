import requests
import urllib
import time
import array 
import csv
import re
from bs4 import BeautifulSoup
import urllib.parse 

profile_links = [];
candidates_matrix = [];

url = 'https://www.socialdemocrats.ie/our-candidates/'
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")
# all_a = soup.findAll("div", {"class": "et_pb_promo_description"})
for a in soup.find_all("div", {"class": "et_pb_promo_description"}):
		profile_links.append(a.a['href']); 

i = 0
for url in profile_links:
	response = requests.get(url)
	soup = BeautifulSoup(response.text, "html.parser")
	name = soup.find("h1", {"class": "entry-title"})
	constituency = soup.find("p", {"class": "color-red"})
	fb = soup.find("a", {"class": "fb"})
	twitter = soup.find("a", {"class": "twt"})
	candidates_matrix.append(name.string.strip() +', ' + constituency.string.strip()
	+', '+ fb['href'].strip() +', ' + twitter['href'].strip() + ', ' + url.replace("\"", ""));

with open("tmp/social_democrats.csv","w+") as my_csv:
    csvWriter = csv.writer(my_csv,delimiter='\n')
    csvWriter.writerow(candidates_matrix)





















		