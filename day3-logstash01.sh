kill -9 $(ps aux | grep logstash | awk '{print $2}')
logstash -f ./logstash.conf
