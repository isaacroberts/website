'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "92c70f286b1a446deed293e3244ea9c4",
"index.html": "d70643dabdb4f85a8c2ad958c3a6e25c",
"/": "d70643dabdb4f85a8c2ad958c3a6e25c",
"main.dart.js": "ef8fcbbab6d9112662c481d28d30e737",
"flutter.js": "a85fcf6324d3c4d3ae3be1ae4931e9c5",
"favicon.png": "026eb8b6bf2eecd71c0b6faa066b5701",
"icons/Icon-192.png": "a7afd1ac4968c53f964cae0df7c9ea2e",
"icons/Icon-maskable-192.png": "a7afd1ac4968c53f964cae0df7c9ea2e",
"icons/Icon-maskable-512.png": "5db97a5f47bee41fe14997172e7c4725",
"icons/Icon-512.png": "5db97a5f47bee41fe14997172e7c4725",
"manifest.json": "27799cfb3a8a47f1d1581dca1e4887bf",
"assets/AssetManifest.json": "264183e08fa0ae17d5b8d2b3272afd5c",
"assets/NOTICES": "e21e7bc8ef8e7be6d46ca7bfc3b29a25",
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
"assets/packages/flutter_chat_ui/assets/icon-seen.png": "b9d597e29ff2802fd7e74c5086dfb106",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-seen.png": "10c256cc3c194125f8fffa25de5d6b8a",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-attachment.png": "9c8f255d58a0a4b634009e19d4f182fa",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-error.png": "5a59dc97f28a33691ff92d0a128c2b7f",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-arrow.png": "8efbd753127a917b4dc02bf856d32a47",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-send.png": "2a7d5341fd021e6b75842f6dadb623dd",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-document.png": "e61ec1c2da405db33bff22f774fb8307",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-delivered.png": "b6b5d85c3270a5cad19b74651d78c507",
"assets/packages/flutter_chat_ui/assets/icon-attachment.png": "17fc0472816ace725b2411c7e1450cdd",
"assets/packages/flutter_chat_ui/assets/icon-error.png": "4fceef32b6b0fd8782c5298ee463ea56",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-seen.png": "684348b596f7960e59e95cff5475b2f8",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-attachment.png": "fcf6bfd600820e85f90a846af94783f4",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-error.png": "872d7d57b8fff12c1a416867d6c1bc02",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-arrow.png": "3ea423a6ae14f8f6cf1e4c39618d3e4b",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-send.png": "8e7e62d5bc4a0e37e3f953fb8af23d97",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-document.png": "4578cb3d3f316ef952cd2cf52f003df2",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-delivered.png": "28f141c87a74838fc20082e9dea44436",
"assets/packages/flutter_chat_ui/assets/icon-arrow.png": "678ebcc99d8f105210139b30755944d6",
"assets/packages/flutter_chat_ui/assets/icon-send.png": "34e43bc8840ecb609e14d622569cda6a",
"assets/packages/flutter_chat_ui/assets/icon-document.png": "b4477562d9152716c062b6018805d10b",
"assets/packages/flutter_chat_ui/assets/icon-delivered.png": "b064b7cf3e436d196193258848eae910",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/gpt/chatgpt_logo.png": "0be38af0287655ee2a000bee8c543698",
"assets/assets/gpt/user_icon.png": "6ccb4b1fe4af1cb9219d20649d0c8f9a",
"assets/assets/images/bg_sky_wide.jpg": "de042c91c138a168345c605ef0bdd721",
"assets/assets/images/ott_clipped.png": "426f2818fb2fd11f05f716d5f83bb746",
"assets/assets/images/MagicVocals.png": "c4ed77cdd350f4d5c02367e19b8625da",
"assets/assets/images/bg_mtns_edited_1.png": "c2dbfba48bbcd8915fa936d4bae669f9",
"assets/assets/images/bg_mtns_edited.jpg": "4a59cce99e553950a7d642f2aeef455a",
"assets/assets/images/bg_mtns_edited.png": "96e5f4cd3d83f8afc0b1baa4152fa347",
"assets/assets/images/robot_bartender.jpg": "1134fbc45e970f19f831f5a57d1346e0",
"assets/assets/images/bg_sky.jpg": "c47a3f54ef05765248142780d08cccee",
"assets/assets/images/deepmind.jpg": "e356e77d07e7f82875dfa4ada80b6b2b",
"assets/assets/images/call_center.jpg": "4229c3bfb2efc9fbb6500b09a66b8d45",
"assets/assets/images/animation.jpg": "3ddea9ff83bb77958713be096261b995",
"assets/assets/images/coffee_header_shrink.png": "c474464f5f1149f99e719ecfb935f4cf",
"assets/assets/images/email_cta.jpg": "6158e161a2b8916796579747c01ba63c",
"assets/assets/images/coffee_header.png": "0aa1a3ec7fc3b75e88532dd2e2edc76c",
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
"assets/assets/lottie/caliper.json": "78725a4347254c42f72a473711202da2",
"assets/assets/lottie/responsive.json": "f70bb8bffcbef5d0adf8645a6869aca8",
"assets/assets/lottie/brush.json": "2e65f035ac3590b3a5617db6f26019aa",
"assets/assets/lottie/brush.svg": "b1b46d1eaba5943d7a21d2ffdab953b7",
"assets/assets/lottie/rivebot_transform.riv": "66732ab50f0f524547050d1d1d3cfd1c",
"assets/assets/lottie/responsive.svg": "39f147b5fef79a2f42dd4a2df3318ced",
"assets/assets/lottie/caliper.svg": "fead0624948a1da3181b641cc485bcca",
"assets/assets/card_bgs/bg_sky.jpg": "9ec5ed71bfac74c91a6b185c2e22ed81",
"assets/assets/card_bgs/firmbee-com-gcsNOsPEXfs-unsplash.jpg": "27f0c26f5d77808f0981807546b8ef1f",
"assets/assets/card_bgs/spacex--p-KCm6xB9I-unsplash.jpg": "a56be26ca2efc29d1d5e8f1a2c888229",
"assets/assets/card_bgs/matteo-vistocco-Dph00R2SwFo-unsplash.jpg": "59a5719bc769fda04e042d5983e2eaa4",
"assets/assets/card_bgs/diego-ph-fIq0tET6llw-unsplash.jpg": "00aaa530836fd663fedd8d76b101290b",
"assets/assets/card_bgs/mika-baumeister-gjPSrg4xSNM-unsplash.jpg": "3d949e599350f67a9f884041902b20b3",
"assets/assets/card_bgs/mockups.jpg": "710a6d2d925fef51acf1b0405c8da222",
"assets/assets/card_bgs/headway-5QgIuuBxKwM-unsplash.jpg": "3549471b6f1c1cd51c9e810aaf55d6ec",
"assets/assets/card_bgs/hunter-haley-s8OO2-t-HmQ-unsplash.jpg": "dd70affedae768644a84971958993da2",
"assets/assets/card_bgs/jason-goodman-Oalh2MojUuk-unsplash.jpg": "8ca81dc6ac09c99e9428124969a98409",
"assets/assets/card_bgs/jo-szczepanska-5aiRb5f464A-unsplash.jpg": "94625eca8a79ca0fe4d28ecc7b8cbf61",
"assets/assets/card_bgs/moritz-mentges-XZuqMUiSdgc-unsplash.jpg": "ad8abed276a53ce5e063e9585e509462",
"assets/assets/card_bgs/planning.jpg": "8a53f1882dc7e3bb92deab013da15606",
"assets/assets/card_bgs/mika-baumeister-_Xesb_PEygM-unsplash.jpg": "52e235b9c2873ee9dbc1218b9d74659d",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
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
