import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:sixam_mart/view/screens/dashboard/dashboard_screen.dart';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../util/images.dart';
import '../../base/inner_custom_app_bar.dart';


// #docregion platform_imports
// Import for Android features.
// Import for iOS features.



class WebviewScreen extends StatefulWidget {
  final String url;
//  const WebviewScreen({Key key}) : super(key: key);
  WebviewScreen({@required this.url});

  @override
  State<StatefulWidget> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {


  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

   String url= "";

  @override
  void initState() {
    url=widget.url!=null && widget.url!=""?widget.url:"https://partilespatriotes.org/";
    print("url>>>>${url}");
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }




    JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
      return JavascriptChannel(
          name: 'Toaster',
          onMessageReceived: (JavascriptMessage message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message.message)),
            );
          });
    }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: InnerCustomAppBar(
          title: "",
          leadingIcon: Images.back_arrow,
          ),
      backgroundColor: Color(0xffffffff),
     /* appBar: _buildAppBar(context),*/
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),


      bottomSheet: SizedBox(),
    );
  }
}
  /*_buildAppBar(BuildContext context) {
    return
      AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DashboardScreen()));
        },
      ),
      iconTheme: IconThemeData(
        color: ColorResources.primaryColor, //change your color here
      ),
      centerTitle: true,
      title:
      Text(
        'Prep-Sheet',
        style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 20,
          color: Colors.black,
          decoration: TextDecoration.none,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }*/




