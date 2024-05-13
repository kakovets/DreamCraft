import 'package:dio/dio.dart';

Dio myDio() {
  var dio = Dio(
    BaseOptions(
      // baseUrl: 'http://192.168.0.102/api',
      baseUrl: 'https://dreamcraft-57cb1d4eefdb.herokuapp.com/api',
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json',
      },
      responseType: ResponseType.json,
    ),
  );

  return dio;
}