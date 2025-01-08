import 'package:audiofilereader/audiofileplayer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/widgets/popups/info_popup.dart';

Future<void> handleFirebaseError(String code, BuildContext context) async {
  String message;
  switch (code) {
    case 'invalid-credential':
      message = invalidCredentials;
    case 'network-request-failed':
      message = noConnection;
    case 'email-already-in-use':
      message = emailTaken;
    case 'invalid-email':
      message = invalidEmail;
    case 'unavailable':
      message = serviceUnavailable;
    case 'canceled':
      return;
    default:
      message = unknownError;
  }
  await showInfoPopup(
    context,
    message,
  );
}

Future<void> showInfoPopup(BuildContext context, String desc,
    {String title = error}) async {
  await showDialog(
    context: context,
    builder: (context) => InfoPopup(title: title, desc: desc),
    barrierDismissible: false,
  );
}

Future<bool> checkConnection() async {
  final result = await Connectivity().checkConnectivity();

  if (result.contains(ConnectivityResult.wifi) ||
      result.contains(ConnectivityResult.mobile) ||
      result.contains(ConnectivityResult.ethernet)) {
    return true;
  }
  return false;
}

void playSFX(String path) {
  Audio.load(path)
    ..play()
    ..dispose();
}

Future<void> savePrefs(String key, dynamic value) async {
  final prefs = await SharedPreferences.getInstance();

  if (value is bool) {
    await prefs.setBool(key, value);
  }
  if (value is int) {
    await prefs.setInt(key, value);
  }
  if (value is double) {
    await prefs.setDouble(key, value);
  }
  if (value is String) {
    await prefs.setString(key, value);
  }
  if (value is List<String>) {
    await prefs.setStringList(key, value);
  }
  return;
}

Future<dynamic> loadPrefs(String key, Type type) async {
  final prefs = await SharedPreferences.getInstance();

  if (type == bool) {
    return prefs.getBool(key);
  }
  if (type == int) {
    return prefs.getInt(key);
  }
  if (type == double) {
    return prefs.getDouble(key);
  }
  if (type == String) {
    return prefs.getString(key);
  }
  if (type == List<String>) {
    return prefs.getStringList(key);
  }
  return null;
}
