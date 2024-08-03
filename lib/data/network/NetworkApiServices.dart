import 'dart:convert';
import 'dart:io';

import 'package:attendence_management_sys/data/network/BaseApiServices.dart';
import 'package:attendence_management_sys/data/app_exceptions.dart';
import 'package:attendence_management_sys/resources/app_url.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BasedApiServices {
  @override
  Future getGetApiResponnse(String url) async {
    dynamic responseJson;

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(minutes: 1));
      responseJson = returnResponse(response);
      print(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getDeleteApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .delete(Uri.parse(url))
          .timeout(const Duration(seconds: 15));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    print(data);
    dynamic responseJson;
    try {
      Response response = await post(Uri.parse(url),
              body: jsonEncode(data),
              headers: <String, String>{'Content-Type': 'application/json'})
          .timeout(const Duration(minutes: 1));

      responseJson = returnResponse(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPutApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await put(Uri.parse(url),
              body: jsonEncode(data),
              headers: <String, String>{'Content-Type': 'application/json'})
          .timeout(const Duration(minutes: 1));

      responseJson = returnResponse(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 204:
        return 'no content';
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        return 'unauthorized';
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 406:
        return 'not acceptable';
      case 409:
        return 'conflict';
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communicating with server' +
                'with satus code' +
                response.statusCode.toString());
    }
  }
}
