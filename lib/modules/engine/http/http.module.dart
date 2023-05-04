import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

class HttpClientModule {
  Database? database;
  HttpClientModule({this.database});

  Future<HttpResponse> get(String resourceUrl,
          {String? baseUrl,
          String? username,
          String? password,
          Dio? dioTestClient}) =>
      HttpClient.get(resourceUrl,
          baseUrl: baseUrl,
          username: username,
          password: password,
          database: database,
          dioTestClient: dioTestClient);
}
