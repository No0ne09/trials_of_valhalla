import 'package:audiofilereader/audiofileplayer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trials_of_valhalla/game_components/game_core.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/screens/game_screen.dart';
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

void restartGame(GameCore game, BuildContext context, bool isGameOver) {
  game.closeGame();
  if (!context.mounted) return;
  if (!isGameOver) Navigator.pop(context);
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => const GameScreen(),
  ));
}

void endGame(GameCore game, BuildContext context, bool isGameOver) {
  game.closeGame();
  if (!context.mounted) return;
  if (!isGameOver) Navigator.pop(context);
  Navigator.pop(context);
}

Future<void> savePrefs(String key, dynamic value) async {
  final prefs = await SharedPreferences.getInstance();

  if (value is bool) {
    await prefs.setBool(key, value);
  } else if (value is int) {
    await prefs.setInt(key, value);
  } else if (value is double) {
    await prefs.setDouble(key, value);
  } else if (value is String) {
    await prefs.setString(key, value);
  } else if (value is List<String>) {
    await prefs.setStringList(key, value);
  } else {
    return;
  }
}

Future<dynamic> loadPrefs(String key, Type type) async {
  final prefs = await SharedPreferences.getInstance();

  if (type == bool) {
    return prefs.getBool(key);
  } else if (type == int) {
    return prefs.getInt(key);
  } else if (type == double) {
    return prefs.getDouble(key);
  } else if (type == String) {
    return prefs.getString(key);
  } else if (type == List<String>) {
    return prefs.getStringList(key);
  } else {
    return null;
  }
}
