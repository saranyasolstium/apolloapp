import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:infinite/view/clinic/clinic_global_screen.dart';
import 'package:infinite/view/splash/splash_screen.dart';
import 'package:infinite/widgets/cart_icon.dart';
import 'package:shopify_flutter/shopify_flutter.dart';

import 'utils/packeages.dart';



Future<void> main() async {
 
 
 ShopifyConfig.setConfig(
      storefrontAccessToken: 'e44583241c0b66f362b767ec913c07e9',
      storeUrl: 'https://apollohospitals.myshopify.com',
      adminAccessToken: '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',
      storefrontApiVersion: '2024-04',
      cachePolicy: CachePolicy.cacheAndNetwork,
      language: 'en',
    );

 
  final HttpLink httpLink = HttpLink(
      'https://apollohospitals.myshopify.com/admin/api/2024-04/graphql.json',
      defaultHeaders: {
        'X-Shopify-Access-Token': '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',
      });

  

  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    ),
  );
  // WIDGET INITIALIZATION
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DioClient.init();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // TO UPDATE STATUS BAR COLORS
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: colorPrimaryDark,
    // navigation bar color
    statusBarColor: colorPrimaryDark,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: colorPrimaryDark,
    // status bar color
    statusBarIconBrightness: Brightness.dark,
    //<-- For Android SEE HERE (light icons)
    statusBarBrightness: Brightness.dark, //<-- For iOS SEE HERE (light icons)
  ));
  // SHARED PREFERENCE INITIALIZATION
  sharedPreferences = await SharedPreferences.getInstance();
  // LOCAL DB
  localDBHelper = DBHelper2();
  localDBHelper?.init();
  Get.put(BadgeController());

  ClinicGlobalScreen().storeData();

  // ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  // FRESH CHAT INIT
  // Freshchat.init(EndPoints.freshChatAppId, EndPoints.freshChatAppKey,
  //     EndPoints.freshChatSDK,
  //     cameraCaptureEnabled: true,
  //     gallerySelectionEnabled: true,
  //     responseExpectationEnabled: true,
  //     teamMemberInfoVisible: true,
  //     userEventsTrackingEnabled: true,
  //     fileSelectionEnabled: true
  //     );

  runApp(GraphQLProvider(client: client, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: colorPrimaryDark));
    return Sizer(
      builder: (context, orientation, deviceType) {
        return LifeCycleManager(
          child: GetMaterialApp(
            enableLog: true,
            defaultTransition: Transition.cupertino,
            transitionDuration: const Duration(seconds: 2),
            opaqueRoute: Get.isOpaqueRouteDefault,
            popGesture: Get.isPopGestureEnable,
            initialBinding: NetworkBinding(),
            debugShowCheckedModeBanner: false,
            title: appName,
            theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                unselectedWidgetColor: Colors.blueGrey,
                primaryColor: colorPrimary,
                splashColor: Colors.blue,
                // timePickerTheme: zzTimePickerTheme,
                inputDecorationTheme: const InputDecorationTheme(
                  alignLabelWithHint: true,
                  filled: true,
                  focusColor: colorPrimary,
                  fillColor: white,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorPrimary),
                  ),
                ),
                appBarTheme: const AppBarTheme(
                  foregroundColor: white,
                  iconTheme: IconThemeData(color: white),
                )),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
