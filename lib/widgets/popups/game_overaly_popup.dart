import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trials_of_valhalla/game_components/game_core.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';
import 'package:trials_of_valhalla/screens/game_screen.dart';
import 'package:trials_of_valhalla/widgets/buttons/main_button.dart';

class GameOveralyPopup extends StatelessWidget {
  const GameOveralyPopup({
    required this.game,
    this.isGameOver = false,
    this.score,
    super.key,
  });
  final GameCore game;
  final bool isGameOver;
  final int? score;
  void _restartGame(GameCore game, BuildContext context) {
    game.closeGame();
    if (!context.mounted) return;
    if (!isGameOver) Navigator.pop(context);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const GameScreen(),
    ));
  }

  void _endGame(GameCore game, BuildContext context) {
    game.closeGame();
    if (!context.mounted) return;
    if (!isGameOver) Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            isGameOver
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$scored\n$score $points",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontFamily: defaultFontFamily,
                          ),
                    ),
                  )
                : MainButton(
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
                _restartGame(
                  game,
                  context,
                );
              },
              icon: const Icon(Icons.restart_alt),
            ),
            MainButton(
              icon: const Icon(Icons.exit_to_app),
              text: exit,
              onPressed: () async {
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                _endGame(
                  game,
                  context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
