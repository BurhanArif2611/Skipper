import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get_connect/http/src/request/request.dart';

import 'package:sixam_mart/data/model/response/address_model.dart';
import 'package:sixam_mart/data/model/response/error_response.dart';
import 'package:sixam_mart/data/model/response/module_model.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as Http;

import '../model/body/news_submit_body.dart';
import '../model/body/report_incidence_body.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  SharedPreferences sharedPreferences;
  static  String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 60;

  String token;
  Map<String, String> _mainHeaders;

  ApiClient({@required this.appBaseUrl, @required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN);

    if (Foundation.kDebugMode) {
      print('Token: $token');
    }
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    int _moduleID;
    if (GetPlatform.isWeb &&
        sharedPreferences.containsKey(AppConstants.MODULE_ID)) {
      try {
          _moduleID = ModuleModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.MODULE_ID))).id;
      print("_moduleID>123>"+_moduleID.toString());
      } catch (e) {}

     /* try {
          _moduleID = ModuleModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.MODULE_ID))).id;
      } catch (e) {}*/


    }
    updateHeader(
      token,
      _addressModel == null ? null : _addressModel.zoneIds,
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      _moduleID,
    );
  }

  void updateHeader(String token, List<int> zoneIDs, String languageCode, int moduleID) {
      print("moduleID>>>"+moduleID.toString());
    if(moduleID != null){
      if(moduleID ==1){
        moduleID=AppConstants.ModelID;
      }
    }
      Map<String, String> _header;
     _header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        /*,
        'Authorization': ' ${token!=null?'Bearer ' +token:'Basic REVNTzpERU1PMTIz'}',*/
      };

    _mainHeaders = _header;
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic> query, Map<String, String> headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: ${appBaseUrl+uri}\nHeader: $_mainHeaders');
      }
      Http.Response _response = await Http.get(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      print('------------${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
  Future<Response> getMatchData(String uri,
      {Map<String, dynamic> query, Map<String, String> headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: ${AppConstants.MATCH_LIST_BASE_URL+uri}\nHeader: $headers');
      }
      Http.Response _response = await Http.get(
        Uri.parse(AppConstants.MATCH_LIST_BASE_URL + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      print('------------${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String> headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      /*  print('====> API Body: $body');*/
        print('====> API Body: $appBaseUrl$uri');
      }

     /* final body = {
        'grant_type': 'password',
        'age': '87',
      };*/
      print('====> API Body<::::>  $body');
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body:jsonEncode(body)/*:Uri(queryParameters: body).query*/,
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      print('====> API Body:'+e.toString());
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }Future<Response> postMatchData(String uri, dynamic body,
      {Map<String, String> headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> Header1: $_mainHeaders');
        print('====> API Body: $uri');
        print('====> API Body<::::>  ${headers}');
      }
      Http.Response _response = await Http.post(
        Uri.parse( uri),
        body:jsonEncode(body)/*Uri(queryParameters: body).query*/,
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      print('====> API Body:'+e.toString());
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
  Future<Response> postJoinTeamData(String uri, Map<String, String> headers) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> Header1: $_mainHeaders');
        print('====> API Body: $uri');
        print('====> API Body<::::>  ${headers}');
      }
      Http.Response _response = await Http.post(
        Uri.parse( uri),
        headers:headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      print('====> API Body:'+e.toString());
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
  Future<Response> getTeamListData(String uri,
      Map<String, String> headers) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: ${uri}\nHeader: $_mainHeaders');
        print('====> Header: $headers');
      }
      Http.Response _response = await Http.get(
        Uri.parse( uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      print('------------${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }


  Future<Response> getJsonData(String uri, dynamic body,
      {Map<String, String> headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      /*  print('====> API Body: $body');*/
        print('====> API URL: $appBaseUrl$uri');
      }

     /* final body = {
        'grant_type': 'password',
        'age': '87',
      };*/
      print('====> API Body<::::>  $body');
      final Uri uriNew = Uri.https(AppConstants.BASE_URL, uri, body);
      Http.Response _response = await Http.get(uriNew).timeout(Duration(seconds: timeoutInSeconds));
      /*Http.Response _response = await Http.get(
        Uri.parse(appBaseUrl + uri),
        body:jsonEncode(body)*//*:Uri(queryParameters: body).query*//*,
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));*/
      return handleResponse(_response, uri);
    } catch (e) {
      print('====> API response Error:'+e.toString());
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postModelData(String uri, ReportIncidenceBody body) async {
    Map<String, String> header;
    header = {
      'Content-Type': 'application/json'/*,
      'Authorization': ' ${token!=null?'Bearer ' +token:'Basic REVNTzpERU1PMTIz'}',*/
    };
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $header');
      /*  print('====> API Body: $body');*/
        print('====> API Body: $appBaseUrl$uri');
      }

      print('==12==> API Body<:>  ${jsonEncode(body)}');
      Http.Response _response = await Http.post(Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: header ,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      print('====> API Body:'+e.toString());
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
  Future<Response> postResultData(String uri, Answers body) async {
    Map<String, String> header;
    header = {
      'Content-Type': 'application/json'/*,
      'Authorization': ' ${token!=null?'Bearer ' +token:'Basic REVNTzpERU1PMTIz'}',*/
    };
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $header');
      /*  print('====> API Body: $body');*/
        print('====> API Body: $appBaseUrl$uri');
      }

      print('==12==> API Body<:>  ${jsonEncode(body)}');
      Http.Response _response = await Http.post(Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: header ,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      print('====> API Body:'+e.toString());
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String> headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API postMultipartData Call: $uri\nHeader: $_mainHeaders');
        print('====> API multipartBody size: ${multipartBody.length.toString()}');
        //print('====> API postMultipartData Body: $body with ${multipartBody.length} picture');
      }
      _mainHeaders.addAllIf(_mainHeaders,
          {AppConstants.Store_ID: AppConstants.StoreID.toString()});
      print('====> API postMultipartData Call: $uri\nHeader: $_mainHeaders');
      Http.MultipartRequest _request =
          Http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      _request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          Uint8List _list = await multipart.file.readAsBytes();
          _request.files.add(Http.MultipartFile(
            multipart.key,
            multipart.file.readAsBytes().asStream(),
            _list.length,
            filename: '${DateTime.now().toString()}.png',
          ));
        }
      }
      _request.fields.addAll(body);
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());
      return handleResponse(_response, uri);
    } catch (e) {
      print('====> API Body:'+e.toString());
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String> headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl + uri),
        body:jsonEncode(body) /*Uri(queryParameters: body).query*/,
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri, {Map<String, String> headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request.headers,
          method: response.request.method,
          url: response.request.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.errors[0].message);
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if (Foundation.kDebugMode) {
      print(
          '====> API Response123: [${_response.statusCode}] $uri\n${(_response.body.toString())}');
      // print('====> API Response123: [${_response.statusCode}] $uri\n${json.decode(_response.body.toString())}');
    }
    return _response;
  }


}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
