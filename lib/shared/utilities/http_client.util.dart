import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpResponse {
  late int statusCode;
  late dynamic body;
  HttpResponse({required int statusCode, required dynamic body}) {
    this.statusCode = statusCode;
    this.body = body;
  }
}

class HttpClient {
  findById() {}

  update() {}

  static Future<http.Response> create(String url, data) {
    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': data,
      }),
    );
  }

  static Future<HttpResponse> get(String url,
      {required String username, required String password}) async {
    final authToken =
        HttpClient.setToken(username: username, password: password);

    try {
      final Response response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'Basic $authToken'},
      );

      return HttpResponse(
          statusCode: response.statusCode, body: json.decode(response.body));
    } catch (error) {
      throw Exception(error);
    }
  }

  static Future<http.Response> delete(String id, String url) async {
    final http.Response response = await http.delete(
      Uri.parse('$url/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Basic'
      },
    );

    return response;
  }

  static setToken({required String username, required String password}) {
    return base64Encode(utf8.encode('$username:$password'));
  }
}
