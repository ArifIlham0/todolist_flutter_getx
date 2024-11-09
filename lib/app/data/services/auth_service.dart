import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_get_new/app/constants/config.dart';
import 'package:todolist_get_new/app/data/models/request/auth_req.dart';
import 'package:todolist_get_new/app/data/models/response/login_res.dart';
import 'package:todolist_get_new/app/utils/export.dart';

class AuthService {
  final Dio dio = Dio();

  Future<bool> me(String username) async {
    String? token = await UserPreferences().getToken();
    print(username);
    print(token);

    try {
      final response = await dio.get(
        "$baseUrl/auth/me/$username",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Berhasil get me ${response.data}");
        return true;
      } else {
        print("Gagal get me ${response.data}");
        return false;
      }
    } on DioException catch (e) {
      print("Error dio me ${e.response?.data}");
      return false;
    }
  }

  Future<bool> login(AuthRequest model) async {
    try {
      final response = await dio.post(
        "$baseUrl/auth/login",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(model),
      );

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        String? userId = loginResponseFromJson(response.data).id;
        String? username = loginResponseFromJson(response.data).username;
        String? token = loginResponseFromJson(response.data).token;

        await prefs.setString("userId", userId);
        await prefs.setString("username", username);
        await prefs.setString("token", token);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print("Error dio login ${e.response?.data}");
      return false;
    }
  }

  Future<bool> register(AuthRequest model) async {
    try {
      final response = await dio.post(
        "$baseUrl/auth/register",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(model),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print("Error dio register ${e.response?.data}");
      return false;
    }
  }
}
