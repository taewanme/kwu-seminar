wget https://raw.githubusercontent.com/taewanme/kwu-seminar/main/day3-kibana.yml
sudo rm -f /etc/kibana/kibana.yml
sudo mv ./day3-kibana.yml /etc/kibana/kibana.yml
sudo systemctl restart kibana
sudo systemctl status kibana
