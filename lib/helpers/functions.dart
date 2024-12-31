import 'package:audiofilereader/audiofileplayer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
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
