wget https://raw.githubusercontent.com/taewanme/kwu-seminar/main/3day-kibana.yml
sudo rm -f /etc/kibana/kibana.yml
sudo mv ./3day-kibana.yml /etc/kibana/kibana.yml
sudo systemctl restart kibana
sudo systemctl status kibana
