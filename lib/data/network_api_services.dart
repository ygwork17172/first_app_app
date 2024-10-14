import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_hello_word_app/data/app_exceptions.dart';
import 'package:flutter_hello_word_app/data/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> patchApi(var data, String url) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      // Ajoutez ici d'autres headers si nécessaire
    };

    dynamic responseJson;
    try {
      final response = await http
          .patch(Uri.parse(url), body: jsonEncode(data), headers: headers)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('Internet connection error');
    } on RequestTimeOut {
      throw RequestTimeOut('Request timed out');
    }

    return responseJson;
  }

  @override
  Future<dynamic> putApi(var data, String url) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    dynamic responseJson;
    try {
      final response = await http
          .put(Uri.parse(url), body: jsonEncode(data), headers: headers)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('Internet connection error');
    } on RequestTimeOut {
      throw RequestTimeOut('Request timed out');
    }

    return responseJson;
  }

  @override
  Future<dynamic> deleteApi(var data, String url) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    dynamic responseJson;
    try {
      final response = await http
          .delete(Uri.parse(url), headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('Internet connection error');
    } on RequestTimeOut {
      throw RequestTimeOut('Request timed out');
    }
    return responseJson;
  }

  @override
  Future<dynamic> getApi(String url) async {
    Map<String, String> headers = <String, String>{
      // Ajoutez ici d'autres headers si nécessaire
    };

    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('Internet connection error');
    } on RequestTimeOut {
      throw RequestTimeOut('Request timed out');
    }
    return responseJson;
  }

  Future<Uint8List> getImageApi(String url) async {
    Map<String, String> headers = <String, String>{
      // Ajoutez ici d'autres headers si nécessaire
    };

    Uint8List responseBytes;
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));

      responseBytes = response.bodyBytes;
    } on SocketException {
      throw InternetException('Internet connection error');
    } on RequestTimeOut {
      throw RequestTimeOut('Request timed out');
    }
    return responseBytes;
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: headers)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('Internet connection error');
    } on RequestTimeOut {
      throw RequestTimeOut('Request timed out');
    }

    return responseJson;
  }

  @override
  Future<dynamic> postAnonymousApi(var data, String url) async {
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('Internet connection error');
    } on RequestTimeOut {
      throw RequestTimeOut('Request timed out');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case HttpStatus.ok:
        return jsonDecode(response.body);
      case HttpStatus.badRequest:
      case HttpStatus.unauthorized:
        return jsonDecode(response.body);
      default:
        throw FetchDataException(
            'Error occurred while communicating with server: ${response.statusCode}');
    }
  }
}
