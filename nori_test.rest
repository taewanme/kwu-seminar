%%bash
curl -XGET localhost:9200/_analyze \
-H "Content-Type:application/json"  \
-d '{"tokenizer":"nori_tokenizer", "text":"대한민국은 전서계 10대 각국이 되었다."}' | jq .
