import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import '../service/dio.dart';
import '../utils/utils.dart';

class Auth extends ChangeNotifier {
  bool _authenticated = false;
  User? _user;
  User? get user => _user;
  final storage = const FlutterSecureStorage();
  bool get authenticated => _authenticated;

  Future register({credential}) async {
    try {
      dio.Response res = await myDio().post(
        '/auth/registration',
        data: credential,
      );

      String token = await res.data['data']['token'];
      await getUser(token);
      await storeToken(token);
    } on dio.DioException catch (e) {
      log('Error: $e');
      log('Response: ${e.response!.data}');
    }
    notifyListeners();
  }

  Future login({required Map credential}) async {
    try {
      dio.Response response = await myDio().post(
        '/auth/login',
        data: json.encode(credential),
      );
      switch (response.statusCode) {
        case 201: {

          if (response.data['data']['token'] == null) {
            return;
          }
          String token = response.data['data']['token'];
          await getUser(token);
          await storeToken(token);

          _authenticated = true;

        }
        default: log('message: ${response.data['message']}');
      }

    } on dio.DioException catch (e) {
      log('Error: $e');
      log('Response: ${e.response!.data}');
    }
    notifyListeners();
  }

  Future getUser(String? token) async {
    try {
      dio.Response response = await myDio().get(
        '/users/me',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      _authenticated = true;
      _user = User.fromJson(response.data);

    } on dio.DioException catch (e) {
      log('Error: $e');
      log('Response: ${e.response!.data}');
      _authenticated = false;
    }
    notifyListeners();
  }

  Future logout() async {
    final token = await storage.read(key: 'auth');
    _authenticated = false;
    var response = await myDio().post(
      '/auth/logout',
      options: dio.Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    log('response = ${response.data}');

    await deleteToken();
    notifyListeners();
  }

  Future subscribeToPlan(int planId) async {
    final token = await storage.read(key: 'auth');

    var response = await myDio().patch(
      '/users/subscribe',
      options: dio.Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: jsonEncode({ 'plan_id': planId }),
    );

    switch (response.statusCode) {
      case 200: {
        getUser(token);
      }
      default: log('Something went wrong');
    }
    notifyListeners();
  }

  Future unsubscribe() async {
    String? token = await Utils.getToken();
    try {
      dio.Response response = await myDio().patch(
        '/users/cancel-plan',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      switch (response.statusCode) {
        case 200: {
          getUser(token);
        }
        default: log('Something went wrong');
      }
    } on dio.DioException catch (e) {
      log('Error: $e');
      log('Response: ${e.response!.data}');
    }
    notifyListeners();
  }

  Future changeMe(Map<String, dynamic> data) async {
    String? token = await Utils.getToken();
    try {
      dio.Response response = await myDio().patch(
        '/users/change-me',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode(data),
      );

      switch (response.statusCode) {
        case 200: {
          getUser(token);
        }
        default: log('Something went wrong');
      }
    } on dio.DioException catch (e) {
      log('Error: $e');
      log('Response: ${e.response!.data}');
    }
    notifyListeners();
  }

  Future chooseCategory(int index) async {
    final token = await storage.read(key: 'auth');
    try {
      var response = await myDio().patch(
        '/users/choose-category',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode({ 'category_id': index }),
      );
      log('subscribeToCategory data ${response.data}');

      getUser(token);
    } on dio.DioException catch (e) {
      log('Error: $e');
      log('Response: ${e.response!.data}');
    }
  }

  Future storeToken(String token) async {
    await storage.write(key: 'auth', value: token);
  }

  Future deleteToken() async {
    await storage.delete(key: 'auth');
  }
}