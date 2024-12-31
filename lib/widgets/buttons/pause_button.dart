import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/game_components/game_core.dart';
import 'package:trials_of_valhalla/widgets/popups/game_overaly_popup.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({
    required this.game,
    super.key,
  });
  final GameCore game;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: IconButton(
        onPressed: () {
          game.pauseEngine();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => GameOveralyPopup(
              game: game,
            ),
          );
        },
        icon: const Icon(
          Icons.pause,
          size: 32,
        ),
      ),
    );
  }
}
