import 'dart:async';
import 'dart:io';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/data/model/response/order_model.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sixam_mart/view/screens/checkout/widget/payment_failed_dialog.dart';

import '../../base/custom_snackbar.dart';

class PaymentScreen extends StatefulWidget {
  final OrderModel orderModel;
  PaymentScreen({@required this.orderModel});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedUrl;
  double value = 0.0;
  bool _isLoading = true;
  PullToRefreshController pullToRefreshController;
  MyInAppBrowser browser;


  @override
  void initState() {
    super.initState();
    print("type>>>>>>>>"+widget.orderModel.orderType);
    if(widget.orderModel.id== -12){
      selectedUrl =widget.orderModel.orderType.toString();
    }else {
      selectedUrl =
      '${AppConstants.BASE_URL}/payment-mobile?customer_id=${widget.orderModel
          .userId}&order_id=${widget.orderModel.id}';
    }
    print("type>>>>>>>>"+selectedUrl);
    _initData();
  }
  /*@override
  void dispose() {
    WidgetsBinding.instance.removeObserver(context);
    super.dispose();
  }*/

  void _initData() async {
    browser = MyInAppBrowser(orderID: widget.orderModel.id.toString(), orderType: widget.orderModel.orderType);

    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

      bool swAvailable = await AndroidWebViewFeature.isFeatureSupported(AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      bool swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController = AndroidServiceWorkerController.instance();
        await serviceWorkerController.setServiceWorkerClient(AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            print(request);
            return null;
          },
        ));
      }
    }

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.black,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          browser.webViewController.reload();
        } else if (Platform.isIOS) {
          browser.webViewController.loadUrl(urlRequest: URLRequest(url: await browser.webViewController.getUrl()));
        }
      },
    );
    browser.pullToRefreshController = pullToRefreshController;

    await browser.openUrlRequest(
      urlRequest: URLRequest(url: Uri.parse(selectedUrl)),
      options: InAppBrowserClassOptions(
        inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(useShouldOverrideUrlLoading: true, useOnLoadResource: true),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () => _exitApp(),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: CustomAppBar(title: 'payment'.tr, onBackPressed: () => _exitApp()),
        body: Center(
          child: Container(
            width: Dimensions.WEB_MAX_WIDTH,
            child: Stack(
              children: [
                _isLoading ? Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                ) : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _exitApp() async {
    return Get.dialog(PaymentFailedDialog(orderID: widget.orderModel.id.toString()));
  }

}

class MyInAppBrowser extends InAppBrowser {
  final String orderID;
  final String orderType;
  MyInAppBrowser({@required this.orderID, @required this.orderType, int windowId, UnmodifiableListView<UserScript> initialUserScripts})
      : super(windowId: windowId, initialUserScripts: initialUserScripts);

  bool _canRedirect = true;

  @override
  Future onBrowserCreated() async {
    print("\n\nBrowser Created!\n\n");
  }

  @override
  Future onLoadStart(url) async {
    print("\n\nStarted: $url\n\n");
    _redirect(url.toString());
  }

  @override
  Future onLoadStop(url) async {
    pullToRefreshController?.endRefreshing();
    print("\n\nStopped: $url\n\n");
    _redirect(url.toString());
  }

  @override
  void onLoadError(url, code, message) {
    pullToRefreshController?.endRefreshing();
    print("Can't load [$url] Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    if (progress == 100) {
      pullToRefreshController?.endRefreshing();
    }
    print("Progress: $progress");
  }

  @override
  void onExit() {
    if(_canRedirect) {
      if(orderID=='-12'){
        Get.back();
      }
      else{
      Get.dialog(PaymentFailedDialog(orderID: orderID));}
    }
    print("\n\nBrowser closed!\n\n");
  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(navigationAction) async {
    print("\n\nOverride ${navigationAction.request.url}\n\n");
    return NavigationActionPolicy.ALLOW;
  }

  @override
  void onLoadResource(response) {
    print("Started at: " + response.startTime.toString() + "ms ---> duration: " + response.duration.toString() + "ms " + (response.url ?? '').toString());
  }

  @override
  void onConsoleMessage(consoleMessage) {
    print("""
    console output:
      message: ${consoleMessage.message}
      messageLevel: ${consoleMessage.messageLevel.toValue()}
   """);
  }

  void _redirect(String url) {
    print("url>>>>"+url);
    print("url>>>>"+_canRedirect.toString());
    if(_canRedirect) {
      bool _isSuccess = url.contains('success') && url.contains(AppConstants.BASE_URL);
      bool _isFailed = url.contains('fail') && url.contains(AppConstants.BASE_URL);
      bool _isCancel = url.contains('cancel') && url.contains(AppConstants.BASE_URL);
      print("url>>>>"+_isSuccess.toString());
      print("url>>>>"+_isFailed.toString());
      print("url>>>>"+_isCancel.toString());
      if (_isSuccess || _isFailed || _isCancel) {
        _canRedirect = false;
        close();
      }
     /* if(orderID=='-12'){
        close();
      }*/
      if (_isSuccess) {
        if(orderID=='-12'){
          showCustomSnackBar('Your Add Fund request has been successfully placed. The same will reflect in your account within 24 Hours.', isError: false);
          Get.back();

        }else {
          Get.offNamed(RouteHelper.getOrderSuccessRoute(orderID));
        }
      } else if (_isFailed || _isCancel) {
        if(orderID=='-12'){
          showCustomSnackBar('We are unable to process your request please try after some time.', isError: true);
          Get.back();

        }else {
        Get.offNamed(RouteHelper.getOrderSuccessRoute(orderID));}
      }
    }
  }

}