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

# Scrape for twitter links
# count = 1
# f = open("tmp/fine_gael-candidates.txt", "w+")
# while count <= 20:
# 	url = 'https://election2019.finegael.ie/candidates?page=' + str(count)
# 	response = requests.get(url)
# 	soup = BeautifulSoup(response.text, "html.parser")
# 	for a in soup.find_all(href=re.compile("/candidates/candidate/")):
# 		print('https://election2019.finegael.ie' + a['href'])
# 		f.write('https://election2019.finegael.ie' + a['href'] + '\n')
# 	count += 1
# f.close;

count = 0;
finegeal_links = open('tmp/fine_gael-candidates.txt', 'r')
for line in finegeal_links:
	url = line.rstrip('\n').replace(' ', '') 
	x = url.split('/')
	print("Constituency: " + x[5])
	print("Area: " + x[6])
	print("Candidate: " + x[7])
	# print(url)
	response = requests.get(url)
	soup = BeautifulSoup(response.text, "html.parser")
	# print(soup)
	twitter = ""
	twitters = soup.find_all("a", {"class": "fa-twitter"})
	for twit_link in twitters:
		if twit_link['href'] != "https://twitter.com/FineGael":
			twitter = urllib.parse.urlsplit(twit_link['href'])
			if twitter[2] == "/search":
				pass
			else:
				count = count + 1
				print(count)
				print("https://twitter.com" + twitter[2])
