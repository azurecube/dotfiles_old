#! /bin/bash

sudo apt-get -y install git
git clone https://github.com/azurecube/dotfiles.git

# link and setup when clone succeeded
if [ $? == 0 ]; then
  cd dotfiles
  bash link.sh
  bash setup.sh
fi
