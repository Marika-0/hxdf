#!/bin/bash

# C++ dependencies
sudo apt-get install -y build-essentials;

# HashLink dependencies (1.11.0)
sudo apt-get install -y libpng-dev;
sudo apt-get install -y libturbojpeg0-dev;
sudo apt-get install -y libvorbis-dev;
sudo apt-get install -y libopenal-dev;
sudo apt-get install -y libsdl2-dev;
sudo apt-get install -y libmbedtls-dev;
sudo apt-get install -y libuv1-dev;


# Java dependencies (11)
sudo apt-get install -y openjdk-11-jdk;
sudo apt-get install -y openjdk-11-jre;


# Lua dependencies (5.1)
sudo apt-get install -y lua5.1;
sudo apt-get install -y luarocks;
sudo luarocks install lrexlib-pcre;
sudo luarocks install environ;
sudo luarocks install luasocket;
sudo luarocks install luv;
sudo luarocks install bit32;
sudo luarocks install luautf8;


# PHP dependencies (7.3)
sudo apt-get install -y php7.4-cli;
sudo apt-get install -y php-mbstring;

# If an error regarding 'mbstring' still occurs, try:
# sudo sed -i "s/;extension=mbstring/extension=mbstring/g" /etc/php/7.3/cli/php.ini


# Python (3.7.3)
sudo apt-get install -y python3;
