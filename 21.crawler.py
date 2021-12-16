import requests
from bs4 import BeautifulSoup

req = requests.get('https://www1.president.go.kr/petitions/603055')
html = req.text
soup = BeautifulSoup(html, 'html.parser')

title = soup.select_one('#cont_view > div.cs_area > div.new_contents > div > div.petitionsView_left > div > h3')
title = title.text
print(title)

agree_count = soup.select_one('#cont_view > div.cs_area > div.new_contents > div > div.petitionsView_left > div > h2 > span')
agree_count = agree_count.text
print(agree_count)

category = soup.select_one('#cont_view > div.cs_area > div.new_contents > div > div.petitionsView_left > div > div.petitionsView_info > ul > li:nth-child(1)')
category = category.text
category = category[4:]
print(category)


opendate = soup.select_one('#cont_view > div.cs_area > div.new_contents > div > div.petitionsView_left > div > div.petitionsView_info > ul > li:nth-child(2)')
opendate = opendate.text
opendate = opendate[4:]
print(opendate)

closedate = soup.select_one('#cont_view > div.cs_area > div.new_contents > div > div.petitionsView_left > div > div.petitionsView_info > ul > li:nth-child(3)')
closedate = closedate.text
closedate = closedate[4:]
print(closedate)

channel = soup.select_one('#cont_view > div.cs_area > div.new_contents > div > div.petitionsView_left > div > div.petitionsView_info > ul > li:nth-child(4)')
channel = channel.text
channel = channel[3:-6]
print(channel)

data = [title, agree_count, category, opendate, closedate, channel]
print(", ".join(data))
