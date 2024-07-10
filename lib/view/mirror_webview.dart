import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../utils/packeages.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({super.key});

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late InAppWebViewController _webViewController;
  final GlobalKey webViewKey = GlobalKey();
  CameraController? cameraController;

  @override
  void initState() {
    permission();
    super.initState();
    loading = true;
  }

  void permission() async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.microphone,
        Permission.photos,
        Permission.storage,
        Permission.audio
      ].request();
    } catch (g) {
      debugPrint('$g');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: loginTextColor,
        leading: IconButton(
            onPressed: () {
              setState(() {
                Get.back();
              });
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text('Virtual Mirror'),
      ),
      body: loading
          ? Stack(
              children: [
                InAppWebView(
                  key: webViewKey,
                  initialUrlRequest:
                      URLRequest(url: Uri.parse(EndPoints.virtualMirror)),
                  initialOptions: InAppWebViewGroupOptions(
                    android: AndroidInAppWebViewOptions(
                      loadWithOverviewMode: true,
                      loadsImagesAutomatically: true,
                      saveFormData: true,
                      useOnRenderProcessGone: true,
                      domStorageEnabled: true,
                      clearSessionCache: true,
                      thirdPartyCookiesEnabled: true,
                      useHybridComposition: true,
                      geolocationEnabled: true,
                      hardwareAcceleration: true,
                      safeBrowsingEnabled: false,
                      allowContentAccess: true,
                      allowFileAccess: true,
                      offscreenPreRaster: true,
                      needInitialFocus: true,
                      databaseEnabled: true,
                      mixedContentMode:
                          AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
                    ),
                    crossPlatform: InAppWebViewOptions(
                      useShouldOverrideUrlLoading: true,
                      useOnDownloadStart: true,
                      useOnLoadResource: true,
                      mediaPlaybackRequiresUserGesture: true,
                      javaScriptEnabled: true,
                      incognito: false,
                      allowFileAccessFromFileURLs: true,
                      javaScriptCanOpenWindowsAutomatically: true,
                      allowUniversalAccessFromFileURLs: true,
                      transparentBackground: true,
                    ),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  androidOnPermissionRequest:
                      (InAppWebViewController controller, String origin,
                          List<String> resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  },
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
