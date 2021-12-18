import requests
from bs4 import BeautifulSoup
import time
from kafka import KafkaProducer

boots_str='localhost:9092,localhost:9093,localhost:9094'

producer = KafkaProducer( bootstrap_servers=boots_str )

for i in range(603001, 603056):
    req = requests.get('https://www1.president.go.kr/petitions/'+str(i))
    html = req.text
    soup = BeautifulSoup(html, 'html.parser')

    title = soup.select_one('#cont_view > div.cs_area > div.new_contents > div > div.petitionsView_left > div > h3')
    title = title.text

    agree_count = soup.select_one('#cont_view > div.cs_area > div.new_contents > div > div.petitionsView_left > div > h2 > span')
    agree_count = agree_count.text
    
    category = soup.select_one('#cont_view > div.cs_area > div.new_contents > div > div.petitionsView_left > div > div.petitionsView_info > ul > li:nth-child(1)')
    category = category.text
    category = category[4:]

    opendate = soup.select_one('#cont_view > div.cs_area > div.new_contents > div > div.petitionsView_left > div > div.petitionsView_info > ul > li:nth-child(2)')
    opendate = opendate.text
    opendate = opendate[4:]

    closedate = soup.select_one('#cont_view > div.cs_area > div.new_contents > div > div.petitionsView_left > div > div.petitionsView_info > ul > li:nth-child(3)')
    closedate = closedate.text
    closedate = closedate[4:]

    channel = soup.select_one('#cont_view > div.cs_area > div.new_contents > div > div.petitionsView_left > div > div.petitionsView_info > ul > li:nth-child(4)')
    channel = channel.text
    channel = channel[3:-6]

    contents = soup.select_one('#cont_view > div.cs_area > div.new_contents > div > div.petitionsView_left > div > div.petitionsView_write > div.View_write')
    contents = contents.text
    escapes = '\b\n\r\t\\' 
    for c in escapes: 
        contents = contents.replace(c, '') 
    
    contents = contents.replace(c, '"')

    json_str = f'{{"title":"{title}", "agree_count":{agree_count}, "category": "{category}", "opendate": "{opendate}", "closedate": "{closedate}", "channel": "{channel}", "contents": "{contents}"}}'

    producer.send('crawlingtopic', str.encode(json_str))
    time.sleep(1)
