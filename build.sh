
# Build
rm -r templates
cd flutter/
# flutter clean
flutter build web --release --base-href=/web/
cd ..

mv flutter/build/web templates
