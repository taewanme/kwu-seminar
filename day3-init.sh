###################################
## cleaning old env
## kill Processes (Kafaka, Zookeeper, Producer, Consumer)
###################################
echo "=== "
kill -9 $(ps aux | grep java | awk '{print $2}')
sleep 5

###################################
## cleaning env
###################################
rm -rf /home/opc/data
rm -rf /home/opc/kafka_2.12-3.0.0
rm -rf /home/opc/kafka
rm -rf /home/opc/*.log
rm -rf /home/opc/*.tar
rm -rf /home/opc/log
rm -rf /home/opc/notebook.log
rm -rf /home/opc/*.ipynb
sudo rm -rf /tmp/zookeeper

###################################
## Installing Kafka Env for Hands-on-lab of 3 day
###################################
wget https://dlcdn.apache.org/kafka/3.0.0/kafka_2.12-3.0.0.tgz
tar -xf ./kafka_2.12-3.0.0.tgz
ln -s ./kafka_2.12-3.0.0 ./kafka
rm ./kafka_2.12-3.0.0.tgz

wget https://raw.githubusercontent.com/taewanme/kwu-seminar/main/server0.properties
wget https://raw.githubusercontent.com/taewanme/kwu-seminar/main/server1.properties
wget https://raw.githubusercontent.com/taewanme/kwu-seminar/main/server2.properties

mv ./server0.properties ./kafka/config/
mv ./server1.properties ./kafka/config/
mv ./server2.properties ./kafka/config/

###################################
## Installing Python Package 
###################################
pip3 install --user kafka-python 
pip3 install --user bs4

###################################
## Starting processes(Zookeeper & Kafka Broker)
###################################
nohup ./kafka/bin/zookeeper-server-start.sh ./kafka/config/zookeeper.properties > zookeeper.log &
sleep 15
nohup ./kafka/bin/kafka-server-start.sh ./kafka/config/server0.properties > broker0.log &
sleep 5
nohup ./kafka/bin/kafka-server-start.sh ./kafka/config/server1.properties > broker1.log &
sleep 5
nohup ./kafka/bin/kafka-server-start.sh ./kafka/config/server2.properties > broker2.log &
sleep 5


###################################
## Creating Topic
###################################
./kafka/bin/kafka-topics.sh \
--create --bootstrap-server localhost:9092,localhost:9093,localhost:9094 \
--replication-factor 3 --partitions 3 \
--topic crawling_topic

###################################
## Starting Console-Consumer
###################################
./kafka/bin/kafka-console-consumer.sh \
--bootstrap-server localhost:9092,localhost:9093,localhost:9094 \
--topic crawling_topic --from-beginning



