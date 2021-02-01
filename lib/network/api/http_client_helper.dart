import 'dart:async';
import 'dart:convert';

import 'package:carimakan/utils/config.dart';
import 'package:carimakan/utils/project_exception.dart';
import 'package:carimakan/utils/shared_value.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpClientHelper {
  final client = http.Client();

  final String _baseUrl = baseUrl();
  static const Duration timeout = Duration(seconds: 60);

  Map<String, String> _buildHeaders({
    @required AuthType authType,
    String bearerToken,
  }) {
    if (authType == AuthType.BEARER) {
      return {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      };
    }
    return {
      'Content-type': 'application/json',
    };
  }

  String _buildUrl({String baseUrl, @required String endpoint}) {
    return baseUrl ?? _baseUrl + endpoint;
  }

  Future<dynamic> get({
    String baseUrl,
    @required String endpoint,
    AuthType authType = AuthType.BEARER,
    String bearerToken,
  }) async {
    try {
      var responseJson;

      final String url = _buildUrl(baseUrl: baseUrl, endpoint: endpoint);
      final Map<String, String> headers = _buildHeaders(
        authType: authType,
        bearerToken: bearerToken,
      );

      // print(">>> url: $url");

      final response = await client.get(url, headers: headers).timeout(timeout);
      responseJson = await _returnResponse(response);
      return responseJson;
    } on UnauthorizedException catch (e) {
      throw UnauthorizedException(e);
    } on ServerErrorException catch (e) {
      throw ServerErrorException(e);
    }
  }

  Future<dynamic> post({
    String baseUrl,
    @required String endpoint,
    AuthType authType = AuthType.BEARER,
    String bearerToken,
    dynamic body,
    String contentType,
    dynamic encoding,
  }) async {
    try {
      var responseJson;
      final String url = _buildUrl(baseUrl: baseUrl, endpoint: endpoint);
      final Map<String, String> headers = _buildHeaders(
        authType: authType,
        bearerToken: bearerToken,
      );

      // print(">>> url: $url");
      // print(">>> body: $body");

      var response;
      if (body == null) {
        response = await client.post(url, headers: headers).timeout(timeout);
      } else {
        if (encoding == null) {
          response = await http
              .post(url, headers: headers, body: body)
              .timeout(timeout);
        } else {
          response = await http
              .post(url, headers: headers, body: body, encoding: encoding)
              .timeout(timeout);
        }
      }

      responseJson = await _returnResponse(response);
      return responseJson;
    } on UnauthorizedException catch (e) {
      throw UnauthorizedException(e);
    } on ServerErrorException catch (e) {
      throw ServerErrorException(e);
    }
  }

  Future<dynamic> put({
    String baseUrl,
    @required String endpoint,
    AuthType authType = AuthType.BEARER,
    String bearerToken,
    String basicUsername,
    String basicPassword,
    dynamic body,
  }) async {
    try {
      var responseJson;

      final String url = _buildUrl(baseUrl: baseUrl, endpoint: endpoint);
      final Map<String, String> headers = _buildHeaders(
        authType: authType,
        bearerToken: bearerToken,
      );

      // print(">>> url: $url");
      // print(">>> headers: $headers");
      // print(">>> body: $body");

      var response;
      if (body == null) {
        response = await client.put(url, headers: headers).timeout(timeout);
      } else {
        response =
            await http.put(url, headers: headers, body: body).timeout(timeout);
      }

      responseJson = await _returnResponse(response);
      return responseJson;
    } on UnauthorizedException catch (e) {
      throw UnauthorizedException(e);
    } on ServerErrorException catch (e) {
      throw ServerErrorException(e);
    }
  }

  Future<dynamic> delete({
    String baseUrl,
    String endpoint,
    AuthType authType = AuthType.BEARER,
    String bearerToken,
  }) async {
    try {
      var responseJson;

      final String url = _buildUrl(baseUrl: baseUrl, endpoint: endpoint);

      final Map<String, String> headers = _buildHeaders(
        authType: authType,
        bearerToken: bearerToken,
      );

      final response = await client
          .delete(_baseUrl + url, headers: headers)
          .timeout(timeout);

      responseJson = await _returnResponse(response);
      return responseJson;
    } on UnauthorizedException catch (e) {
      throw UnauthorizedException(e);
    } on ServerErrorException catch (e) {
      throw ServerErrorException(e);
    }
  }

  dynamic _returnResponse(http.Response response) async {
    // print(">>> response ${response.body} | ${response.body.runtimeType}");
    // print(">>> status ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
      case 201:
        try {
          var responseJson = json.decode(response.body);
          if (responseJson is List) return response.body;
          return responseJson;
        } on FormatException {
          return null;
        }
        break;

      case 400:
        try {
          var responseJson = json.decode(response.body);
          // print(">>> response type ${responseJson.runtimeType}");
          throw BadRequestException(responseJson);
        } catch (e) {
          throw BadRequestException(response.body.toString());
        }
        break;
      case 401:
        throw UnauthorizedException(response.body.toString());
      case 403:
        throw ForbiddenException(response.body.toString());
      case 404:
        throw NotFoundException(response.body.toString());
      case 500:
      case 502:
        throw ServerErrorException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
