'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "f75d19bf6974dae136df15c364b2c45b",
"assets/AssetManifest.bin.json": "bfac46b09c7535aa3d8217f930a645a2",
"assets/AssetManifest.json": "4a8a914be75ea381e7d81c6a2e9103a9",
"assets/assets/flags/ae.svg": "4ec18c3220fa253c299e7f105b1676f8",
"assets/assets/flags/at.svg": "52224ffd42dee033adf13bf3541b2d5c",
"assets/assets/flags/au.svg": "8b435b0a03d196d98eec620143fd21d0",
"assets/assets/flags/ca.svg": "d3196a834be04b749b8a03ca8625a300",
"assets/assets/flags/cn.svg": "ebce0873ec0a24933f8a33fdc4d228bc",
"assets/assets/flags/cy.svg": "07c1b7872ecbfabc957daa5418c8c474",
"assets/assets/flags/cz.svg": "91d9506e51fec821efdad708a850e9be",
"assets/assets/flags/de.svg": "3e2bdbd90a1f746bac50ab015acdb8c1",
"assets/assets/flags/es.svg": "ecdd146401d560c663b3fa2a4de53e75",
"assets/assets/flags/fr.svg": "2cd17ba82af8375f1f74095c174e1be0",
"assets/assets/flags/hk.svg": "0ae753097ae384d9a5cdd920cb8ece8b",
"assets/assets/flags/hu.svg": "b3639aa8a83ae957f961022b0822c92c",
"assets/assets/flags/ie.svg": "b5b8b5e3afeaf8ec14e44093c9fe101a",
"assets/assets/flags/it.svg": "0da133dde7666ece4881a948ab93b0b0",
"assets/assets/flags/jp.svg": "49847a06c0016b6ec14926472cc0ccb6",
"assets/assets/flags/kr.svg": "6765d805c3b4c36641a8c03074dc7c9f",
"assets/assets/flags/my.svg": "170eac3ba7de8da6ea43dc0c5467dc40",
"assets/assets/flags/nl.svg": "0ef23d0ead9461769928d4a8cc3b554c",
"assets/assets/flags/pl.svg": "484a2334eb63b2d05ef593a8e952f25f",
"assets/assets/flags/sg.svg": "d6bca051989949e8439d2a303ef651ae",
"assets/assets/flags/tr.svg": "c98daa499af2c52800523658337fa0ea",
"assets/assets/flags/uk.svg": "541f54ba4f826750d21981a7bb4046a0",
"assets/assets/flags/us.svg": "d4beec6c1827262fda0e20b56c801ced",
"assets/assets/icons/arrow-left.svg": "1d5dad984c984c23350a57798d25c47d",
"assets/assets/icons/arrow-up-right.svg": "747e98d2849ff04b43a832b36b71b659",
"assets/assets/icons/atlas.svg": "277aeb6c087c9499c952bd8b4f149983",
"assets/assets/icons/bookmark-open.svg": "59e17e434691459eb270b5249d67d8ce",
"assets/assets/icons/bookmark.svg": "fd922aeea6a9f0448f140927d6809b8d",
"assets/assets/icons/books.svg": "0be13bdf8921548634922f88bae20f8c",
"assets/assets/icons/brain.svg": "6a50746053b43bd9784f5cd41aa71e25",
"assets/assets/icons/briefcase.svg": "7898c9744f4688325fd4b2d4d47e8989",
"assets/assets/icons/calender.svg": "0735da59936c0a23552de72e297206c2",
"assets/assets/icons/career.svg": "2876763d0226bc9632f686fe6bcb8979",
"assets/assets/icons/caret-down.svg": "5f76fd64770e005a3c09640cfd2a2656",
"assets/assets/icons/caret-right.svg": "3f69caf6229c424f7e9502e2322d1421",
"assets/assets/icons/caret-top.svg": "aef36bc8e83df3a1e29d631d934db407",
"assets/assets/icons/chalkboard_teacher.svg": "20efe4c879823077b478fad10284a0da",
"assets/assets/icons/checkbox_blank.svg": "60f7bc6537c8fffd6fb4b12bf22e6342",
"assets/assets/icons/checkbox_fill.svg": "2efb5475c2911a1d04780db6d9d9a7d0",
"assets/assets/icons/comunity.svg": "fa120ee2300b7bcd02558bc401cf3aeb",
"assets/assets/icons/consulant_goverement.png": "fb1bd0d67847699a3aefd6137739535f",
"assets/assets/icons/consulant_goverement.svg": "ab92cd52dc25b43bccc12c596c4ca6a8",
"assets/assets/icons/consulant_whatsapp.svg": "64ce610deba03350cc8a6cca08f47292",
"assets/assets/icons/consultant.svg": "48b57e59d3d0463baec359e709061f40",
"assets/assets/icons/country.svg": "8d367792beef49c2918da984a5bafafa",
"assets/assets/icons/dormitory.svg": "3e434531f56da937e9afeaa6e4a5a826",
"assets/assets/icons/dream_choice.svg": "e699f93e854b823ba11686a3a2f0fcd3",
"assets/assets/icons/expand_down.svg": "5f76fd64770e005a3c09640cfd2a2656",
"assets/assets/icons/filter.svg": "91d05e5f070898fa918d70ba30dfc427",
"assets/assets/icons/global_unversities.svg": "e52f40bce8f1e623e49c1f967558cd04",
"assets/assets/icons/house.svg": "1c4ec2deb0416db34a638606e0be4902",
"assets/assets/icons/house_unselect.svg": "0b06e93a420bdbe1335eb2fa09622bd2",
"assets/assets/icons/kz-flag.svg": "bc89c2bcbb6a0b22dacc512cad2f1c1a",
"assets/assets/icons/nazarbaev.svg": "fc7acb0b5ea7822c85f6212030ed5369",
"assets/assets/icons/notebook.svg": "835dede951c2f373a2fdc5b4b43ec67d",
"assets/assets/icons/profile.svg": "9649f22c01d576fb53f03c5352f69c5e",
"assets/assets/icons/program.svg": "e561a8b98994a1a7849a344ce4379d27",
"assets/assets/icons/reload.svg": "0d8459c61015d66874522518568e2cc9",
"assets/assets/icons/resources.svg": "06ed67d33a64ceb2ee757eafc9663098",
"assets/assets/icons/rounded_x.svg": "c1028e1e27a9c271e1804ac80f126225",
"assets/assets/icons/route.svg": "17270e0d89b271cdfbbe7223722d4a6b",
"assets/assets/icons/ru-flag.svg": "850b61dea6d045549ab8a87524a392fd",
"assets/assets/icons/safe_choice.svg": "5a7643f3f2be526331e7e155b232a40f",
"assets/assets/icons/settings.svg": "c5cfb7f86e6e57ea48e7d904a8da2ba3",
"assets/assets/icons/specialties.svg": "a37483d103ae561a9f0885ea2eefd28b",
"assets/assets/icons/success.svg": "ea363e63446441d0ae968a854579c7bf",
"assets/assets/icons/target_choice.svg": "99e858256cf6ec96a52ffafa41663cf6",
"assets/assets/icons/uk-flag.svg": "861afe064c38cd1bb1f0fb7673765487",
"assets/assets/icons/universities.svg": "72e87963d4e60cab723c1493a92bc5de",
"assets/assets/icons/university.svg": "d20d794adb4380f58fe742bfb64a057b",
"assets/assets/icons/waving_hand.svg": "d0f2307ca5a9fe75a0308151a89a9911",
"assets/assets/icons/whatsapp.svg": "064f063724db1196e241c2af2f5c7874",
"assets/assets/icons/x.svg": "262aa46bcefa74dd96bb2a03bcfcc293",
"assets/assets/images/avatar.png": "dcfcadd31b8a4c9c48eed25f3faaf5d4",
"assets/assets/images/avatar_image.png": "db17bfffa0322f87733a995dc9075f02",
"assets/assets/images/calendar.png": "068d7c4b928c78d7ee1921712584733b",
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
"assets/assets/images/waving_hand.png": "b0e6d21e13c332525bbefcc3e217fe1a",
"assets/assets/jsondata/counselorTasks.json": "9fc51bda0fe4fb35138e52e69f8dffd9",
"assets/assets/jsondata/guidanceTasks.json": "515cd8e23339e5a68db2a13a4b023f7c",
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
"assets/assets/testingmaterials/azbel.json": "be8d9559bcf2e1014664dbee466465b4",
"assets/assets/testingmaterials/cddq.json": "36925909ae6f898db98940bb575c2f26",
"assets/assets/testingmaterials/gardner.json": "99b859e906c6a4b1e23f637dedb315e2",
"assets/assets/testingmaterials/holland.json": "33bfb8fc20171066c4f203acdf0d117c",
"assets/assets/testingmaterials/klimov.json": "e727a1a13700e7caffd619649cbca4c9",
"assets/assets/testingmaterials/mbti.json": "9ec75254fb8bed838b5a87cb21ffea50",
"assets/assets/testingmaterials/qstnGeneral10Grade.json": "15409bd6725456f6332f94e1b5cd7f1b",
"assets/assets/testingmaterials/qstnGeneral9Grade.json": "859cacc1c5842d4da918adf5871e686d",
"assets/assets/translations/kk.json": "cd19ed4ceae9fc79759fe6c7e6722556",
"assets/assets/translations/ru.json": "4060e49e47ee3fe7ff18fd722b9695b9",
"assets/FontManifest.json": "db83746bde1d2c9ac620bc91654d446b",
"assets/fonts/Inter-Bold.ttf": "7ef6f6d68c7fedc103180f2254985e8c",
"assets/fonts/Inter-ExtraBold.ttf": "a6ed481bff60bc9270904d214947ab13",
"assets/fonts/Inter-Regular.ttf": "37dcabff629c3690303739be2e0b3524",
"assets/fonts/MaterialIcons-Regular.otf": "b25ca8cf47031126b816e6a14a24b859",
"assets/NOTICES": "f941c827d022078eb1839ebc6b61be1c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Bold.ttf": "8fedcf7067a22a2a320214168689b05c",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Duotone.ttf": "c48df336708c750389fa8d06ec830dab",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Fill.ttf": "5d304fa130484129be6bf4b79a675638",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Light.ttf": "f2dc1cd993671b155e3235044280ba47",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor-Thin.ttf": "f128e0009c7b98aba23cafe9c2a5eb06",
"assets/packages/phosphor_flutter/lib/fonts/Phosphor.ttf": "003d691b53ee8fab57d5db497ddc54db",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
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
"flutter_bootstrap.js": "5f82ddb967282b7ee7654bf951ad29b2",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "159b0d59599a003838123b68d3f21593",
"/": "159b0d59599a003838123b68d3f21593",
"main.dart.js": "e4c5c16ad50d460885bff03ebba15f12",
"manifest.json": "3f59a2a08766003186383c07d0d69e97",
"version.json": "3ebc2d5d2dbffb49a303760b3daad0ec"};
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
