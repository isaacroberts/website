#!/bin/bash


# Build
rm -r templates

cd flutter/
flutter clean && flutter build web --release --base-href=/templates/
cd ..
mkdir templates/
cp -R flutter/build/web templates/

# cp flutter/favicon.* flask/tac2/templates/

# Commit
git add .
git commit -m $1

git push


source ~/.bash_profile
n
