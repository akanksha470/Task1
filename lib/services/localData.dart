import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class LocalData {

  static String isLoggedInKey = "isLoggedIn";
  static String passwordKey = "password";
  static String emailKey = "email";

  Future<void> saveUserLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  Future<void> saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(emailKey, email);
  }

  Future<void> saveUserPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(passwordKey, password);
  }

  Future<bool> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(isLoggedInKey);
  }

  Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(emailKey);
  }

  Future<String> getUserPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(passwordKey);
  }

}