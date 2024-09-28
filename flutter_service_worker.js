'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "e6f0969445f92dc5485ef1421d16f6f0",
"assets/AssetManifest.bin.json": "d71b630891785f6688da1827e7a8a710",
"assets/AssetManifest.json": "62c97b9b011f1f7da1fd31aa4401f00c",
"assets/assets/icons/arrow-left.svg": "51046591faab0090fae1b9044d384947",
"assets/assets/icons/arrow-up-right.svg": "5530431c3b0bee36cbfb1b77a79d51e7",
"assets/assets/icons/atlas.svg": "b7db494894653fa9f804bdf357fa6dfe",
"assets/assets/icons/bookmark-open.svg": "e0b5a60a7260a93f073665dc9b68dfb5",
"assets/assets/icons/bookmark.svg": "6fa4aa8605f3c2a137a763da8a3adb56",
"assets/assets/icons/brain.svg": "0bd90b45731253c46596e69b5cd21f30",
"assets/assets/icons/briefcase.svg": "5ab7281be86765b006b9af6b11736cc4",
"assets/assets/icons/career.svg": "bbab282145dc93a24a54b2133cf8b7ea",
"assets/assets/icons/caret-down.svg": "acb467736e3323cb0c70bd77fccc16b2",
"assets/assets/icons/caret-right.svg": "7898585be80cb8ef36acad8ca22552ce",
"assets/assets/icons/caret-top.svg": "95dc3e2c4641641b394e9efb46827d8e",
"assets/assets/icons/chalkboard_teacher.svg": "857461a5d082a58e0288a749b0c44d92",
"assets/assets/icons/checkbox_blank.svg": "cb2aad35663025b95f59b3b11b71ed0c",
"assets/assets/icons/checkbox_fill.svg": "eafa9a413a44408bae675fcc498df656",
"assets/assets/icons/comunity.svg": "7cbac2f988311175ebc5d4af1a3510fa",
"assets/assets/icons/consultant.svg": "3cb54295f52a70d2193f7fc26ec6d1b4",
"assets/assets/icons/dormitory.svg": "6cf780c9d543ccabd80c63d062e0350e",
"assets/assets/icons/dream_choice.svg": "f6f1a082d42c4491ae92bf485b0cedf5",
"assets/assets/icons/expand_down.svg": "acb467736e3323cb0c70bd77fccc16b2",
"assets/assets/icons/filter.svg": "c6b1e9e2a4e58f7179c9741c8a754b88",
"assets/assets/icons/kz-flag.svg": "bc89c2bcbb6a0b22dacc512cad2f1c1a",
"assets/assets/icons/nazarbaev.svg": "df79b25bac60642a5d0cb9aedf5e26cf",
"assets/assets/icons/notebook.svg": "29975ea6b85a9f192f60283d34947cd8",
"assets/assets/icons/profile.svg": "830b384e61915b3ff9e8d93f70a39de5",
"assets/assets/icons/reload.svg": "e38870798123c61bcdb7c19a89cab154",
"assets/assets/icons/resources.svg": "cc85b20d81f381a06cd0d40a1918354e",
"assets/assets/icons/rounded_x.svg": "74dba2b918e694b36371c6a8eb54f5a5",
"assets/assets/icons/ru-flag.svg": "850b61dea6d045549ab8a87524a392fd",
"assets/assets/icons/safe_choice.svg": "4edee418a3664402b148da2021bcd3e9",
"assets/assets/icons/settings.svg": "2d44f72e9d6ab4e6cb153472461dc9c5",
"assets/assets/icons/specialties.svg": "d83e62cc2bb484f12dbbe160bcfd512a",
"assets/assets/icons/target_choice.svg": "61c90420e0c6c86a42f11fd92ecd0ca7",
"assets/assets/icons/uk-flag.svg": "861afe064c38cd1bb1f0fb7673765487",
"assets/assets/icons/universities.svg": "67ded4131d1c883c350ed878cfa95373",
"assets/assets/icons/university.svg": "82b92f3daf3318c070f533457af7620d",
"assets/assets/icons/x.svg": "77364c36c041bedf032447afa1d9cc42",
"assets/assets/images/avatar.png": "dcfcadd31b8a4c9c48eed25f3faaf5d4",
"assets/assets/images/avatar_image.png": "db17bfffa0322f87733a995dc9075f02",
"assets/assets/images/course-image.png": "fa32384fcb35ad981222377fdec593a7",
"assets/assets/images/folder.png": "7ceafb6c9473e5c0f24f8cda65d34f9a",
"assets/assets/images/kz-flag.png": "04ab6b05925ee0a1afc40acd2fa68903",
"assets/assets/images/personal_frame_1.png": "1d98d2171d07e0afebc4d589ae5d90d1",
"assets/assets/images/personal_frame_2.png": "aab805a2a0571c0809329c1b0d52ae4f",
"assets/assets/images/personal_frame_3.png": "a46d06cd0966616a7114b57f6a660c30",
"assets/assets/images/placeholder.png": "037bb2203686fb254bb80a73fa624db7",
"assets/assets/images/profile-dummy.png": "fa3565285e77dad55832928b215d00fb",
"assets/assets/images/ru-flag.png": "9ccc56af6a1ea3efa9202acde64f090e",
"assets/assets/images/splash_image.png": "115eabb425274e4d530aeca2d136ba6a",
"assets/assets/images/splash_phone.png": "9f1331c962278277a0f9ab024c375288",
"assets/assets/images/tel-kz-flag.png": "162487438b883339657585b919024588",
"assets/assets/images/thumb.png": "90c1c7965a7894a85898ab4e29b0a4cf",
"assets/assets/images/tick_dynamic_color.png": "b7ab2e50660c1d8633e45d8d6018aab8",
"assets/assets/images/us-flag.png": "c7ef7aeea67ae3612237fefcaa3b8db3",
"assets/assets/images/verify_email.png": "22f72f29641939d13535002d932ea51e",
"assets/assets/jsondata/counselorTasks.json": "76f5692258a4fbb4de1b0c7b7812598f",
"assets/assets/jsondata/guidanceTasks.json": "6178d81d5edf9b197cbb99b60b08ea9e",
"assets/assets/questionnaire/10kz-1.jpg": "48cde5566311f2b5548d65bd95ee3897",
"assets/assets/questionnaire/10ru-1.jpg": "2352c1d33e4066f142c967c7774a762a",
"assets/assets/questionnaire/11kz-1.jpg": "f8ba74b31a1546a8f6c3236f843a0f88",
"assets/assets/questionnaire/11ru-1.jpg": "b1f4b68521099d94f2a28a22c73ab8c7",
"assets/assets/questionnaire/12kz-1.jpg": "c2e972f68cf5c4de10f26cf98c0858ae",
"assets/assets/questionnaire/12ru-1.jpg": "c2391d2dcca37dd763e95ada8a138ed8",
"assets/assets/questionnaire/13kz-1.jpg": "fec577f3204b25d34ef9694f34938a80",
"assets/assets/questionnaire/13ru-1.jpg": "8b30a77e096c1a474d6a3dee4dee33d8",
"assets/assets/questionnaire/14kz-1.jpg": "bcd17aa0c7f8a66a33ec0dad49e93481",
"assets/assets/questionnaire/14ru-1.jpg": "5bd29b4bd7ff515e915e7d33e930e3e2",
"assets/assets/questionnaire/15kz-1.jpg": "0ca71bfad0738b8dcc28dce219f7c807",
"assets/assets/questionnaire/15ru-1.jpg": "5b58ae45e469b9b10d79ddde903909f7",
"assets/assets/questionnaire/16kz-1.jpg": "f7e4643b93f125d59de2619b199e6bca",
"assets/assets/questionnaire/16ru-1.jpg": "f295bde36e6c97600100a9bac788a9f0",
"assets/assets/questionnaire/17kz-1.jpg": "91133492a1ef8527368901f1b4d45cec",
"assets/assets/questionnaire/17ru-1.jpg": "3bd09f8fe695d64ca2c5ac4ca0c8dadd",
"assets/assets/questionnaire/18kz-1.jpg": "27bf9ecbac6ec3a16331421b00a9b5f2",
"assets/assets/questionnaire/18ru-1.jpg": "f339856c60b6f6cf3023f1a660dac57c",
"assets/assets/questionnaire/1kz-1.jpg": "f8b18342f0c7c9b1f1e9184715b6b909",
"assets/assets/questionnaire/1ru-1.jpg": "74e47dd910b76105eb108eeeb0db2795",
"assets/assets/questionnaire/2kz-1.jpg": "40e9e332d80a69fd3f0b02a43f40f3e0",
"assets/assets/questionnaire/2ru-1.jpg": "62beed7425913d301ce69312e91f0671",
"assets/assets/questionnaire/3kz-1.jpg": "c0cb232c2e3c284ccbbfb66fa04e11e1",
"assets/assets/questionnaire/3ru-1.jpg": "e8e7f69f9a7475f690d53b9664073648",
"assets/assets/questionnaire/4kz-1.jpg": "26ab9e07eea1cc060e836c2e0ee989f1",
"assets/assets/questionnaire/4ru-1.jpg": "c32daed9cd15b1cc201cedf872419877",
"assets/assets/questionnaire/5kz-1.jpg": "be3888b91eedb4a360bbc1216e3f883d",
"assets/assets/questionnaire/5ru-1.jpg": "3d6987cf8d5bd16e80be6a5f77504ec0",
"assets/assets/questionnaire/6kz-1.jpg": "a583c8f0d6de6779a4c35d383f1fb2df",
"assets/assets/questionnaire/6ru-1.jpg": "c694a341a9815030c756a7ee6bdc7769",
"assets/assets/questionnaire/7kz-1.jpg": "06fc33b62ddbf758ed81c06eab409e75",
"assets/assets/questionnaire/7ru-1.jpg": "bfb98822c79a663aca7f714db0e8c5df",
"assets/assets/questionnaire/8kz-1.jpg": "e6b83cb23a4916b034ff0eb9104c079a",
"assets/assets/questionnaire/8ru-1.jpg": "8a3fddacd12d1a07987e6eb6d4b2d280",
"assets/assets/questionnaire/9kz-1.jpg": "3c43817259ddcb8ab9a88370c67dee9c",
"assets/assets/questionnaire/9ru-1.jpg": "a7af375f3515f3bcf8839fe3842c6cb7",
"assets/assets/testingmaterials/azbel.json": "675d29a1b016c718884a79f6c620e4d5",
"assets/assets/testingmaterials/cddq.json": "433a8cafc82cd29c28f708c254d55c7d",
"assets/assets/testingmaterials/gardner.json": "abd7800f231b0c6c9f6abdc06d4c5f1a",
"assets/assets/testingmaterials/holland.json": "7371faae072f1dd347b7c3fba70c5a73",
"assets/assets/testingmaterials/klimov.json": "5979811104a6c8a480f94d956ecc46c7",
"assets/assets/testingmaterials/mbti.json": "a06aca7cf99229f784a973259eb27fcb",
"assets/assets/testingmaterials/qstnGeneral10Grade.json": "60e902e2c646991181bac3828f7e9e85",
"assets/assets/testingmaterials/qstnGeneral9Grade.json": "8d4fd921e1ee32e97a29a9d9ae8098e6",
"assets/assets/translations/en.json": "68795d53c13fcbf4d88415dc26a36102",
"assets/assets/translations/kk.json": "d9fd898bade0a79ff266fdeee52ccaed",
"assets/assets/translations/ru.json": "abaa2f2994f92175348231f5181dc9dc",
"assets/FontManifest.json": "db83746bde1d2c9ac620bc91654d446b",
"assets/fonts/Inter-Bold.ttf": "7ef6f6d68c7fedc103180f2254985e8c",
"assets/fonts/Inter-ExtraBold.ttf": "a6ed481bff60bc9270904d214947ab13",
"assets/fonts/Inter-Regular.ttf": "37dcabff629c3690303739be2e0b3524",
"assets/fonts/MaterialIcons-Regular.otf": "6e13663f71f789fc7bf2eb11980e6459",
"assets/NOTICES": "8b3e335eab82c7f15f46de78fe875b8a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Bold.ttf": "8fedcf7067a22a2a320214168689b05c",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Duotone.ttf": "c48df336708c750389fa8d06ec830dab",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Fill.ttf": "5d304fa130484129be6bf4b79a675638",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Light.ttf": "f2dc1cd993671b155e3235044280ba47",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Thin.ttf": "f128e0009c7b98aba23cafe9c2a5eb06",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor.ttf": "003d691b53ee8fab57d5db497ddc54db",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "7c05ec2fe335700c9aaf08da2002f518",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "1e79e8f6a9473e8af5f8475e5903065b",
"/": "1e79e8f6a9473e8af5f8475e5903065b",
"main.dart.js": "6ddb55d298f32f8630ba0e9bb17bf4c1",
"manifest.json": "fe81cbae8b609740b70fe2e84f5e78e3",
"version.json": "19a9cbf8394f6f99190c4266b67cd33c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
