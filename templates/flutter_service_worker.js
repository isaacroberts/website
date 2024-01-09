'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "92c70f286b1a446deed293e3244ea9c4",
"index.html": "c4ecfe7fb59850f4763a6fccd1738d15",
"/": "c4ecfe7fb59850f4763a6fccd1738d15",
"main.dart.js": "7560ad61a7fbafdea01d58006abbdb37",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "026eb8b6bf2eecd71c0b6faa066b5701",
"icons/Icon-192.png": "a7afd1ac4968c53f964cae0df7c9ea2e",
"icons/Icon-maskable-192.png": "a7afd1ac4968c53f964cae0df7c9ea2e",
"icons/Icon-maskable-512.png": "5db97a5f47bee41fe14997172e7c4725",
"icons/Icon-512.png": "5db97a5f47bee41fe14997172e7c4725",
"manifest.json": "27799cfb3a8a47f1d1581dca1e4887bf",
"assets/AssetManifest.json": "a380d12b7bd51b863dfa73fa36f618e5",
"assets/NOTICES": "18bc0ffc2b43957c43fbbc611bc266b0",
"assets/FontManifest.json": "788f3b60e94973b3e158857a51bf3df4",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "dd74f11e425603c7adb66100f161b2a5",
"assets/packages/fluttericon/lib/fonts/Octicons.ttf": "7242d2fe9e36eb4193d2bc7e521779bf",
"assets/packages/fluttericon/lib/fonts/Maki.ttf": "9ecdcd7d24a2461a55d532b86b2740bd",
"assets/packages/fluttericon/lib/fonts/Brandico.ttf": "791921e9b25210e2551b6eda3f86c733",
"assets/packages/fluttericon/lib/fonts/Entypo.ttf": "58edfaf27b1032ea4778b69297c02b5a",
"assets/packages/fluttericon/lib/fonts/Fontelico.ttf": "3a1e1cecf0a3eae6be5cba3677379ba2",
"assets/packages/fluttericon/lib/fonts/Iconic.ttf": "34e12214307f5f7cf7bc62086fbf55a3",
"assets/packages/fluttericon/lib/fonts/LineariconsFree.ttf": "276b1d61e45eb9b2dde9482545d9e3ac",
"assets/packages/fluttericon/lib/fonts/RpgAwesome.ttf": "99232001effca5cf2b5aa92cc3f3e892",
"assets/packages/fluttericon/lib/fonts/Typicons.ttf": "3386cae1128e52caf268508d477fb660",
"assets/packages/fluttericon/lib/fonts/FontAwesome.ttf": "799bb4e5c577847874f20bd0e9b38a9d",
"assets/packages/fluttericon/lib/fonts/Zocial.ttf": "c29d6e34d8f703a745c6f18d94ce316d",
"assets/packages/fluttericon/lib/fonts/WebSymbols.ttf": "4fd66aa74cdc6e5eaff0ec916ac269c6",
"assets/packages/fluttericon/lib/fonts/Linecons.ttf": "2d0ac407ed11860bf470cb01745fb144",
"assets/packages/fluttericon/lib/fonts/FontAwesome5.ttf": "221b27a41202ddd33990e299939e4504",
"assets/packages/fluttericon/lib/fonts/Elusive.ttf": "23f24df0388819e94db2b3c19841841c",
"assets/packages/fluttericon/lib/fonts/MfgLabs.ttf": "09daa533ea11600a98e3148b7531afe3",
"assets/packages/fluttericon/lib/fonts/Meteocons.ttf": "8b9c7982496155bb39c67eaf2a243731",
"assets/packages/fluttericon/lib/fonts/ModernPictograms.ttf": "5046c536516be5b91c15eb7795e0352d",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "bc9b303c9b3a153a1d417a9c740920ad",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/gpt/chatgpt_logo.png": "0be38af0287655ee2a000bee8c543698",
"assets/assets/gpt/user_icon.png": "6ccb4b1fe4af1cb9219d20649d0c8f9a",
"assets/assets/images/bg_sky_wide.jpg": "de042c91c138a168345c605ef0bdd721",
"assets/assets/images/ott_clipped.png": "426f2818fb2fd11f05f716d5f83bb746",
"assets/assets/images/MagicVocals.png": "c4ed77cdd350f4d5c02367e19b8625da",
"assets/assets/images/bg_mtns_edited_1.png": "c2dbfba48bbcd8915fa936d4bae669f9",
"assets/assets/images/brick3.jpg": "3e5e1376748e75a4c7c401f67ba03414",
"assets/assets/images/bg_mtns_edited.jpg": "4a59cce99e553950a7d642f2aeef455a",
"assets/assets/images/bg_mtns_edited.png": "96e5f4cd3d83f8afc0b1baa4152fa347",
"assets/assets/images/robot_bartender.jpg": "1134fbc45e970f19f831f5a57d1346e0",
"assets/assets/images/brick2.jpg": "382f9ec9fb76ba994b6d6c15578b9a3d",
"assets/assets/images/bg_sky.jpg": "c47a3f54ef05765248142780d08cccee",
"assets/assets/images/brick1.jpg": "e754fb85b8eeb66b2bc33f7eca6e2d29",
"assets/assets/images/deepmind.jpg": "e356e77d07e7f82875dfa4ada80b6b2b",
"assets/assets/images/swimming_deer.jpg": "81b39c9d9d4df702cfd96f2ca60719a2",
"assets/assets/images/call_center.jpg": "4229c3bfb2efc9fbb6500b09a66b8d45",
"assets/assets/images/pink_desk.jpg": "feac858633d2c0925a567a735c3cb8df",
"assets/assets/images/animation.jpg": "3ddea9ff83bb77958713be096261b995",
"assets/assets/images/graf2.jpg": "75772148b4070440cfeb2ad165bc1be3",
"assets/assets/images/coffee_header_shrink.png": "c474464f5f1149f99e719ecfb935f4cf",
"assets/assets/images/graf3.jpg": "897ee38e64f309ddb5477f5564338200",
"assets/assets/images/graf1.jpg": "737b81d7fb7522a1508ec31652a5a7f2",
"assets/assets/images/email_cta.jpg": "6158e161a2b8916796579747c01ba63c",
"assets/assets/images/coffee_header.png": "0aa1a3ec7fc3b75e88532dd2e2edc76c",
"assets/assets/images/white_desk.jpg": "11dc9881f966e7252db65d5437badd3a",
"assets/assets/images/ragnar.png": "b6d14bef9b1c9e12de5e80683333230c",
"assets/assets/images/gpt_bg.png": "061ee19bf5d5bd90978ccb0f20342d4c",
"assets/assets/images/c3po.jpg": "faf8a5b63cdf27962fe670aba6d5f5ea",
"assets/assets/images/data_an.jpg": "6cf62cedcaff048b60b0bab2eeaae8c4",
"assets/assets/images/deepmind2.jpg": "d41a478bfc42b555a0ef4c231a95de55",
"assets/assets/images/bg_field.jpg": "ea7c82323b7fcfc8bfe76ce5a4439657",
"assets/assets/images/graph_bg.jpg": "fe64c7d1370d387b51f0b326452cef6c",
"assets/assets/images/automation.jpg": "0567881d79ab08f31ef3091c1f700703",
"assets/assets/images/starry_small.png": "8658c99bb13c09882e1c9774c1b91ac4",
"assets/assets/images/bg_mtns.jpg": "dd5037f3c15c458ed4b079d48a184b0b",
"assets/assets/images/lemonaid.png": "203fef7b204c01ed6b920b06a0ea85de",
"assets/assets/images/coffee_w_bg.png": "ac01ecdab5fe98b53aa2694179d88790",
"assets/assets/images/bg.jpg": "e54c65d1189329f780f74f833bf3b40f",
"assets/assets/empty.png": "a3356990b84d42e8ae72ed6be871d404",
"assets/assets/loader.gif": "d47e58c71a6e6573f1e35fcb2beeee2a",
"assets/assets/lottie/caliper.json": "73dd680dd042522806d7ef188fadfb46",
"assets/assets/lottie/caliper_white.svg": "fead0624948a1da3181b641cc485bcca",
"assets/assets/lottie/responsive.json": "59a8a8d11a2b54baacf1aed989aea67f",
"assets/assets/lottie/caliper%2520orig.json": "78725a4347254c42f72a473711202da2",
"assets/assets/lottie/brush.json": "da8d10dd89e0b229979ddeaec4c60c85",
"assets/assets/lottie/brush.svg": "42c5022ae7c311e38569a09119e5c7a3",
"assets/assets/lottie/brush_white.svg": "b1b46d1eaba5943d7a21d2ffdab953b7",
"assets/assets/lottie/rivebot_transform.riv": "66732ab50f0f524547050d1d1d3cfd1c",
"assets/assets/lottie/responsive_white.svg": "39f147b5fef79a2f42dd4a2df3318ced",
"assets/assets/lottie/responsive.svg": "2a50966df2ea4d8a3a6f34c9ca9d90f3",
"assets/assets/lottie/caliper.svg": "bc015923b4a5fa54ee11aa33d1ebfa21",
"assets/assets/card_bgs/bg_sky.jpg": "c47a3f54ef05765248142780d08cccee",
"assets/assets/card_bgs/firmbee-com-gcsNOsPEXfs-unsplash.jpg": "079f14ac6e8a63c1f22cb466e94a8f2a",
"assets/assets/card_bgs/spacex--p-KCm6xB9I-unsplash.jpg": "9f6f51736dac8b2c9eedbc52531efc4c",
"assets/assets/card_bgs/matteo-vistocco-Dph00R2SwFo-unsplash.jpg": "1ec2eda0e690141ddee986ffa7870e39",
"assets/assets/card_bgs/diego-ph-fIq0tET6llw-unsplash.jpg": "3ddea9ff83bb77958713be096261b995",
"assets/assets/card_bgs/mika-baumeister-gjPSrg4xSNM-unsplash.jpg": "4266b841429f8abc41a37617c03f2c1f",
"assets/assets/card_bgs/mockups.jpg": "3f48e63738925a24261f9ff06a95afdc",
"assets/assets/card_bgs/headway-5QgIuuBxKwM-unsplash.jpg": "64bd27b777ce956c0ea18fa3e3719e45",
"assets/assets/card_bgs/hunter-haley-s8OO2-t-HmQ-unsplash.jpg": "9fffac7dc24cc46fbe952eb4e6ffa649",
"assets/assets/card_bgs/jason-goodman-Oalh2MojUuk-unsplash.jpg": "33d09731cba4419ea45914f8b77a4c42",
"assets/assets/card_bgs/jo-szczepanska-5aiRb5f464A-unsplash.jpg": "9734dc5142724c350a3a442f85247edc",
"assets/assets/card_bgs/moritz-mentges-XZuqMUiSdgc-unsplash.jpg": "1e9ea0a51c3712c6506c126bb1e416c7",
"assets/assets/card_bgs/planning.jpg": "1f7780e3f8e54090de69282927d2151b",
"assets/assets/card_bgs/mika-baumeister-_Xesb_PEygM-unsplash.jpg": "3ce065b603841a01442ee811384a442b",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "1165572f59d51e963a5bf9bdda61e39b",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/canvaskit.wasm": "19d8b35640d13140fe4e6f3b8d450f04",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
