import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  late http.Response response;

  //String token = '133|xK6yrFQjao7gqzAoAlreawZdfodQM50fZu7Xf3uQ';

  String? token;

  static String version = 'api';

  static String host = 'http://127.0.0.1:8000/';
  // static String host = 'https://omran-dz.com/';

  _setHeadersWithToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    token = storage.getString('access_token');

    return {
      'Content-Type': "application/json",
      'Accept': 'application/json',
      if (token != null) 'Authorization': '$token'
    };
  }

  Future<http.Response> postWithHeader({apiUrl, data}) async {
    var fullUrl = host + version + apiUrl;
    log("-----------------> postWithHeader :");
    log("fullUrl :$fullUrl");
    log("data    :${json.encode(data)}");

    final response = await http.post(Uri.parse(fullUrl),
        body: json.encode(data), headers: await _setHeadersWithToken());
    log("response: ${response.body}");
    log("---------------------------------------");
    return response;
  }

  Future<http.Response> delete({apiUrl, data}) async {
    var fullUrl = host + version + apiUrl;
    log("-----------------> delete :");
    log("fullUrl :$fullUrl");
    log("data    :${json.encode(data)}");
    final response = await http.delete(Uri.parse(fullUrl),
        body: json.encode(data), headers: await _setHeadersWithToken());
    log("response: ${response.body}");
    log("---------------------------------------");
    return response;
  }

  Future<http.Response> post(apiUrl, data) async {
    var fullUrl = host + version + apiUrl;

    log("-----------------> post :");
    log("fullUrl :$fullUrl");
    log("data    :${json.encode(data)}");
    final response = await http.post(Uri.parse(fullUrl),
        body: json.encode(data), headers: await _setHeadersWithToken());
    log("response: ${response.body}");
    log("---------------------------------------");
    return response;
  }

  Future<http.Response> getWithHeader({apiUrl}) async {
    var fullUrl = host + version + apiUrl;
    log("-----------------> getwithHeader :");
    log("fullUrl :$fullUrl");
    final response = await http.get(Uri.parse(fullUrl),
        headers: await _setHeadersWithToken());
    log("response: ${response.body}");
    log("---------------------------------------");
    return response;
  }

  Future<http.Response> get(apiUrl) async {
    var fullUrl = host + version + apiUrl;
    log("-----------------> get :");
    log("fullUrl :$fullUrl");
    final response = await http.get(Uri.parse(fullUrl),
        headers: await _setHeadersWithToken());
    log("response: ${response.body}");
    log("---------------------------------------");
    return response;
  }

  Future<http.StreamedResponse> uploadFilePost(
      {apiUrl,
      Map<String, String>? data,
      fileData,
      List<File>? filePath}) async {
    final storage = await SharedPreferences.getInstance();
    token = storage.getString('access_token')!;
    Map<String, String> headers = {
      'Content-Type': 'application/multipart',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var fullUrl = host + version + apiUrl;
    log("-----------------> uploadeFilePost :");
    log("fullUrl :$fullUrl");
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl))
      ..headers.addAll(headers);
    if (data != null) {
      try {
        request.fields.addAll(data);
      } catch (e) {
        print(e);
      }
    }
    if (filePath != null) {
      filePath.forEach((element) async {
        request.files
            .add(await http.MultipartFile.fromPath(fileData, element.path));
      });
    }

    final response = await request.send();
    log("response: ${response}");
    log("---------------------------------------");
    return response;
  }

  Future<http.StreamedResponse> miltipartPatch(
      {apiUrl,
      Map<String, String>? data,
      fileData,
      required File? filePath}) async {
    print('request sending');
    final storage = await SharedPreferences.getInstance();
    token = storage.getString('access_token')!;

    Map<String, String> headers = {
      'Content-Type': 'application/multipart',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print('after header');
    var fullUrl = host + version + apiUrl;
    var request = http.MultipartRequest('PATCH', Uri.parse(fullUrl))
      ..headers.addAll(headers);
    if (data != null) {
      try {
        request.fields.addAll(data);
      } catch (e) {
        print(e);
      }
    }
    if (filePath != null) {
      request.files
          .add(await http.MultipartFile.fromPath(fileData, filePath.path));
    }

    final response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> miltipartPost(
      {apiUrl, Map<String, String>? data, fileData, filePath}) async {
    await SharedPreferences.getInstance().then((storage) {
      token = storage.getString('access_token')!;
    });
    Map<String, String> headers = {
      'Content-Type': 'application/multipart',
      'Accept': 'application/json',
      'Authorization': token!,
    };
    var fullUrl = host + version + apiUrl;
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl))
      ..headers.addAll(headers);
    if (data != null) {
      try {
        request.fields.addAll(data);
      } catch (e) {
        print(e);
      }
    }
    if (filePath != null) {
      request.files
          .add(await http.MultipartFile.fromPath(fileData, filePath.path));
    }

    final response = await request.send();
    return response;
  }
}
