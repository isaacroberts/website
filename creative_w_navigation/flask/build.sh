#!/bin/bash
source ~/.bash_profile
shopt -s expand_aliases


# Build
rm -r templates
cd flutter/

if [ ! -f "build/web/flutter.js" ]; then
    # Clean because it doesn't remake flutter.js & canvaskit otherwise
    flutter clean
fi

flutter build web --release --base-href=/web/ --web-renderer canvaskit

cd ..

mkdir templates
cp -r flutter/build/web/* templates/

if [ -f "flutter/assets_sheet.csv" ]; then
    # Fixes nested asset folder and 
    # Resizes them to listed sizes
    rm -r templates/assets/assets/
    python ~/Dropbox/scripts/flutter/resize_assets.py resize .
else
    # Fixes fucked assets thing
    mv templates/assets/assets/* templates/assets/
    rm -r templates/assets/assets/
fi
notify
