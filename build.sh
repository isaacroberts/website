#!/bin/bash
source ~/.bash_profile
shopt -s expand_aliases


# Build
rm -r templates
cd flutter/
# flutter clean
flutter build web --release --base-href=/web/ --web-renderer canvaskit
cd ..

mv flutter/build/web templates

notify
