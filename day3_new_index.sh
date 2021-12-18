%%bash
curl -XPUT localhost:9200/national_petition_v2 \
-H 'Content-Type: application/json' \
-d '@./index_setting.json' | jq .
