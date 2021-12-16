#새로운 터니널 오픈
#콘솔 producer 실행
./kafka/bin/kafka-console-producer.sh \
--bootstrap-server localhost:9092,localhost:9093,localhost:9094 \
--topic demo01

#새로운 터니널 오픈
#콘솔 producer 실행
./kafka/bin/kafka-console-consumer.sh \
--bootstrap-server localhost:9092,localhost:9093,localhost:9094 \
--topic demo01 --from-beginning

