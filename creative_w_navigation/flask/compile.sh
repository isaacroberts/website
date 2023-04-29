#!/bin/bash
source ~/.bash_profile
shopt -s expand_aliases


./build.sh
./push.sh "$1" 
# cp flutter/favicon.* flask/tac2/templates/

notify
