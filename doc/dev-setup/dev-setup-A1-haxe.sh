#!/bin/bash

haxe_version="4.1.2";

if command -v haxe &> /dev/null;
then
    installed_haxe_version=$(haxe --version);
    if [ $installed_haxe_version == $haxe_version ];
    then
        printf "Haxe $haxe_version is already installed.\n";
        exit 0;
    else
        printf "Haxe $installed_haxe_version is currently installed.\nReplace with Haxe $haxe_version? [Y/n] ";
        read confirm;
        if [ "$confirm" == "n" ] || [ "$confirm" == "N" ];
        then
            exit 0;
        fi
    fi
fi

cd "$(dirname $0)";

# Always overwrite existing download - to avoid failed download corruption.
rm -f haxe-$haxe_version-linux64.tar.gz;
rm -rf $extract_directory;
wget https://github.com/HaxeFoundation/haxe/releases/download/$haxe_version/haxe-$haxe_version-linux64.tar.gz;
tar -xzf haxe-$haxe_version-linux64.tar.gz;

if ! ls -d */;
then
    printf "No directories exist. Failed to untar binaries?\n";
    exit 1;
fi

extract_directory="$(ls -d */ | grep --colour=never "^haxe_*")";
if [ $(printf $extract_directory | wc -l) != "0" ];
then
    printf "There are $(printf $extract_directory | wc -l) extract-similar directories, but there must be zero.\n";
    exit 1;
fi

cd $extract_directory;
sudo rm -f /usr/bin/haxe;
sudo cp haxe /usr/bin/;
sudo rm -f /usr/bin/haxelib;
sudo cp haxelib /usr/bin/;

if [ ! -d /usr/share/haxe ];
then
    sudo mkdir /usr/share/haxe;
fi
sudo rm -r /usr/share/haxe/std;
sudo cp -r std /usr/share/haxe/;

cd ../;
rm haxe-$haxe_version-linux64.tar.gz;
rm -r $extract_directory;
