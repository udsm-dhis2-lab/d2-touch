import 'dart:convert';

import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:sqflite/sqflite.dart';

class HttpDetails {
  Database? database;
  String? baseUrl;
  String? username;
  String? password;
  User? user;
  HttpDetails({
    this.username,
    this.password,
    this.baseUrl,
    this.database,
  }) {}

  Future<HttpDetails> get() async {
    if (this.username != null &&
        this.password != null &&
        this.baseUrl != null) {
      return this;
    }

    final User? user = await UserQuery(database: database).getOne();
    this.username = user?.username;
    this.password = user?.password;
    this.baseUrl = user?.baseUrl;

    return Future.value(this);
  }

  String get authToken {
    return base64Encode(utf8.encode('${this.username}:${this.password}'));
  }
}
