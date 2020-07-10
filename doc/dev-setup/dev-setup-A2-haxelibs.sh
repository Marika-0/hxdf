#!/bin/bash

haxelib setup ~/.haxelibs;

install_package() {
    if [ -z "$(sudo haxelib list $1 | grep "$2")" ];
    then
        haxelib install $1 $2;
    else
        "Haxelib $1 is installed\n";
    fi
    haxelib set $1 $2;
}

install_package dox        1.5.0;
install_package formatter  1.11.0;
install_package hxcpp      4.1.15;
install_package hxjava     4.0.0-alpha;
install_package hxtf       2.0.2;
