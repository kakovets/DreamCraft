import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:dream_craft/models/category.dart';
import 'package:dream_craft/utils/utils.dart';
import 'package:flutter/material.dart';
import '../models/plan.dart';
import '../models/user.dart';
import '../service/dio.dart';


class CategoryProvider extends ChangeNotifier {
  List<Category> categoriesList = [];
  List<Plan> planList = [];

  Future getCategories({required String locale}) async {
    try {
      dio.Response response = await myDio().get(
        '/categories',
        options: dio.Options(
          headers: {
            'Accept-Language': locale,
          },
        ),
      );
      switch (response.statusCode) {
        case 200: {
          List<Category> newList = [];
          for (var cat in response.data['data']) {
            newList.add(Category.fromJson(cat));
          }
          categoriesList = newList;
        }
        default: log('Something went wrong');
      }

    } on dio.DioException catch (e) {
      log('DioException getCategories:\n${e.toString()}');
      log('DioException getCategories:\n${e.response!.data}');
    }
    notifyListeners();
  }

  Future<Category?> getCategory(int id, {required String locale}) async {
    try {
      dio.Response response = await myDio().get(
        '/categories/$id',
        options: dio.Options(
          headers: {
            'Accept-Language': locale,
          },
        ),
      );
      switch (response.statusCode) {
        case 200: {
          var category = Category.fromJson(response.data['data']);

          var index = categoriesList
              .indexWhere((cat) => cat.id == category.id);

          categoriesList[index] = category;
          await checkIfRated(categoryId: category.id);

          return category;
        }
        default: log('Something went wrong');
      }
      notifyListeners();
    } on dio.DioException catch (e) {
      log('DioException getCategory:\n${e.toString()}');
      log('DioException getCategory:\n${e.response!.data}');
    }
    return null;
  }

  Future checkIfRated({required int categoryId}) async {
    String? token = await Utils.getToken();
    try {
      dio.Response response = await myDio().get(
        '/marks/$categoryId',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      switch (response.statusCode) {
        case 200: {
          var index = categoriesList
              .indexWhere((cat) => cat.id == categoryId);

          categoriesList[index].userRated = response.data['data'];
        }
        default: log('Something went wrong');
      }
      notifyListeners();

    } on dio.DioException catch (e) {
      log('DioException checkIfRated:\n${e.toString()}');
      log('DioException checkIfRated:\n${e.response!.data}');
    }
  }

  Future rateCategory({
    required int categoryId,
    required int mark,
    required String locale,
  }) async {
    String? token = await Utils.getToken();
    try {
      dio.Response response = await myDio().post(
        '/marks',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: json.encode(
          {
            'category_id': '$categoryId',
            'mark': '$mark',
          },
        ),
      );

      switch (response.statusCode) {
        case 201: {
          getCategory(
            categoryId,
            locale: locale,
          );
        }
        default: log('Something went wrong');
      // default: message = response.data['message'];
      }
      notifyListeners();

    } on dio.DioException catch (e) {
      log('DioException rateCategory:\n${e.toString()}');
      log('DioException rateCategory:\n${e.response!.data}');
    }
  }

  Future<User?> getUserById({required int userId}) async {
    String? token = await Utils.getToken();
    try {
      dio.Response response = await myDio().get(
        '/users/$userId',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      switch (response.statusCode) {
        case 200: {
          User user = User.fromJson(response.data);
          return user;
        }
        default: log('Something went wrong');
      }
      notifyListeners();

    } on dio.DioException catch (e) {
      log('DioException getUserById:\n${e.toString()}');
      log('DioException getUserById:\n${e.response!.data}');
    }
    return null;
  }

  Future postComment({
    required int categoryId,
    required String comment,
    required String locale,
  }) async {
    String? token = await Utils.getToken();
    try {
      dio.Response response = await myDio().post(
        '/comments',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode(
            {
              'category_id': '$categoryId',
              'text': comment,
            }
        ),
      );
      switch (response.statusCode) {
        case 201: {
          getCategory(
            categoryId,
            locale: locale,
          );
        }
        default: log('Something went wrong');
      }
      notifyListeners();

    } on dio.DioException catch (e) {
      log('DioException postComment:\n${e.toString()}');
      log('DioException postComment:\n${e.response!.data}');
    }
    return null;
  }


  Future getPlans({required String locale}) async {
    String? token = await Utils.getToken();
    try {
      dio.Response response = await myDio().get(
        '/plans',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept-Language': locale,
          },
        ),
      );

      log('getPlans code ${response.statusCode}');
      log('getPlans data ${response.data}');

      switch (response.statusCode) {
        case 200: {
          List<Plan> newList = [];
          for (var plan in response.data['data']) {
            newList.add(Plan.fromJson(plan));
          }
          planList = newList;
        }
        default: log('Something went wrong');
      }
      notifyListeners();

    } on dio.DioException catch (e) {
      log('DioException getPlans:\n${e.toString()}');
      log('DioException getPlans:\n${e.response!.data}');
    }
  }
}
