#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")"

################################################################################
#                                                                              #
# Script for setting up a development environment.                             #
#                                                                              #
# Reccomended to run through this manually command-by-command rather than      #
# using it as an actual script.                                                #
#                                                                              #
################################################################################

sudo apt-get update

# Background
sudo apt-get install -y git   # 1:2.20.1-2ubuntu1
sudo apt-get install -y cmake # 3.13.4-1build1


# Haxe (4.0.0-rc.5)
wget https://github.com/HaxeFoundation/haxe/releases/download/4.0.0-rc.5/haxe-4.0.0-rc.5-linux64.tar.gz
tar -xvzf tar -xzf haxe-4.0.0-rc.5-linux64.tar.gz
cd haxe_20190912112227_4a745347f

sudo cp -v haxe /usr/bin/
sudo cp -v haxelib /usr/bin/
sudo mkdir -v /usr/share/haxe
sudo cp -rv std /usr/share/haxe/

cd ..
rm -v haxe-4.0.0-rc.5-linux64.tar.gz
rm -rv haxe_20190912112227_4a745347f

printf "\n" | haxelib setup


# Development
sudo haxelib install checkstyle # 2.4.2
sudo haxelib install formatter  # 1.9.1
sudo haxelib install hxtf       # 1.2.0


# C++
sudo haxelib install hxcpp # 4.0.52


# Hashlink (1.10)
sudo apt-get install -y libpng-dev        # 1.6.37-1
sudo apt-get install -y libturbojpeg0-dev # 2.0.3-0ubuntu1
sudo apt-get install -y libvorbis-dev     # 1.3.6-2
sudo apt-get install -y libopenal-dev     # 1:1.19.1-1
sudo apt-get install -y libsdl2-dev       # 2.0.9+dfsg1-1ubuntu1
sudo apt-get install -y libmbedtls-dev    # 2.16.2-1
sudo apt-get install -y libuv1-dev        # 1.30.1-1

wget https://github.com/HaxeFoundation/hashlink/archive/1.10.zip
unzip 1.10.zip
cd hashlink-1.10
make
sudo make install
cd ..
rm -v 1.10.zip
rm -rv hashlink-1.10


# Java (8?)
sudo haxelib install hxjava            # 4.0.0-alpha
sudo apt-get install -y openjdk-11-jdk # 11.0.5+6-1ubuntu2
sudo apt-get install -y openjdk-11-jre # 11.0.5+6-1ubuntu2


# Lua (5.3)
sudo apt-get install -y luarocks   # 2.4.2+dfsg-1
sudo luarocks install lrexlib-pcre # 2.9.0-1
sudo luarocks install environ      # 0.1.0-1
sudo luarocks install luasocket    # 3.0rc1-2
sudo luarocks install luv          # 1.30.1-0
sudo luarocks install bit32        # 5.3.0-1
sudo luarocks install luautf8      # 0.1.1-1


# PHP (7.3)
sudo apt-get install -y php7.3-cli   # 7.3.8-1
sudo apt-get install -y php-mbstring # 2:7.3+69ubuntu2

  # If an error regarding mbstring still occurs, try:
  # sudo sed -i "s/;extension=mbstring/extension=mbstring/g" /etc/php/7.3/cli/php.ini


# Python (3.7.3)
sudo apt-get install -y python3 # 3.7.3-1
