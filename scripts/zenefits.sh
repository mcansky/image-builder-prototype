#!/bin/bash

# Package installation
bash -c 'echo "deb http://archive.ubuntu.com/ubuntu trusty universe" >> /etc/apt/sources.list'

apt-get update

apt-get install -y build-essential python python-dev mysql-server mysql-client \
  libmysqlclient-dev python-virtualenv python-pip python-software-properties \
  software-properties-common chromium-chromedriver libxslt1-dev swig imagemagick \
  libmagickwand-dev libffi-dev liblua5.1 npm unzip libgif4 \
  git openjdk-7-jre-headless curl wget xvfb xfonts-cyrillic \
  xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable \
  x11-xkb-utils poppler-utils libsqlite3-dev libfontconfig1-dev \
  libicu-dev libfreetype6 libssl-dev libpng-dev libjpeg-dev libx11-dev libxext-dev sudo

  # Configure git to use https:// instead of git://
 git config --global url."https://".insteadOf git://
 # Install prince
 wget http://www.princexml.com/download/prince_9.0-5_ubuntu14.04_amd64.deb
 dpkg -i prince_9.0-5_ubuntu14.04_amd64.deb
 ln -s /usr/bin/prince /usr/local/bin/prince
 # Download clojure compiler
 wget https://dl.google.com/closure-compiler/compiler-latest.zip
 unzip -n compiler-latest.zip
 # Add ubuntu user
 usermod -a -G sudo -s /bin/bash ubuntu
 bash -c 'echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'
 # Various symlinks
 ln -s /usr/lib/chromium-browser/chromedriver /usr/local/bin/chromedriver
 ln -s /usr/lib/x86_64-linux-gnu/liblua5.1.so /usr/lib/x86_64-linux-gnu/liblua51.so
 ln -s /usr/bin/nodejs /usr/bin/node
 # Install nvm
 npm install -g nvm
 # Install the right version of node
 node_version="0.12.7"
 for action in 'download' 'build' 'install'; do
   nvm "${action}" "${node_version}"
 done
 # Install bower, ember, ember-cli
 for package in 'bower' 'ember' 'ember-cli' 'phantomjs'; do
   npm install --verbose -g ${package}
 done
 # Install Redis
 add-apt-repository -y ppa:chris-lea/redis-server
 apt-get update
 apt-get install -y redis-server
 # Add 'ubuntu' user to MySQL
 mysqld &
 # Give server time to come up
 sleep 10
 # Add ubuntu user
 mysql -u root -e "create user 'ubuntu'@'localhost'"
 mysql -u root -e "grant all on *.* to 'ubuntu'@'localhost'"
 # Kill mysql daemon
 ps aux | grep mysql | grep -v grep | awk '{print $2}' | xargs kill -TERM
