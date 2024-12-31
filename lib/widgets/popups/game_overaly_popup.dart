import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/game_components/game_core.dart';
import 'package:trials_of_valhalla/helpers/functions.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/widgets/buttons/main_button.dart';

class GameOveralyPopup extends StatelessWidget {
  const GameOveralyPopup({required this.game, super.key});
  final GameCore game;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          MainButton(
            icon: const Icon(Icons.play_arrow),
            text: resume,
            onPressed: () {
              game.resumeEngine();
              Navigator.pop(context);
            },
          ),
          MainButton(
            text: tryAgain,
            onPressed: () {
              restartGame(game, context);
            },
            icon: const Icon(Icons.restart_alt),
          ),
          MainButton(
            icon: const Icon(Icons.exit_to_app),
            text: exit,
            onPressed: () {
              endGame(game, context);
            },
          ),
        ],
      ),
    );
  }
}
