#!/bin/bash

# The download link for HashLink has a different url to the actul version of
# HashLink, so we need these two representations of its version.
hashlink_version="1.11";
hashlink_actual_version="1.11.0";

if command -v hl &> /dev/null;
then
    installed_hashlink_version=$(hl --version);
    if [ $installed_hashlink_version == $hashlink_actual_version ];
    then
        printf "HashLink $hashlink_actual_version is already installed.\n";
        #exit 0;
    else
        printf "HashLink $installed_hashlink_version is currently installed.\nReplace with HashLink $hashlink_actual_version? [Y/n] ";
        read confirm;
        if [ "$confirm" == "n" ] || [ "$confirm" == "N" ];
        then
            exit 0;
        fi
    fi
fi

sudo apt install -y build-essential cmake;

cd "$(dirname $0)";

# Always overwrite existing download - to avoid failed download corruption.
rm -f $hashlink_version.tar.gz;
rm -rf hashlink-$hashlink_version;
wget https://github.com/HaxeFoundation/hashlink/archive/$hashlink_version.tar.gz;
tar -xzf $hashlink_version.tar.gz;

cd hashlink-$hashlink_version;
make;
sudo make install;

cd ../;
rm $hashlink_version.tar.gz;
rm -r hashlink-$hashlink_version;
