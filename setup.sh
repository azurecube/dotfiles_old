#! /bin/sh

sudo apt-get -y install ansible ssh
sudo ansible-playbook -i "localhost" pack.yml

