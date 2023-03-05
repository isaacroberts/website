
# Build
rm -r templates
cd flutter/
# flutter clean
flutter build web --release --base-href=/web/
cd ..
mkdir templates/
cp -R flutter/build/web/ templates/
  
