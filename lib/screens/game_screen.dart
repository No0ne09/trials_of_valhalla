import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials_of_valhalla/game_components/game_core.dart';
import 'package:trials_of_valhalla/helpers/providers.dart';
import 'package:trials_of_valhalla/widgets/buttons/main_button.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shake = ref.watch(shakeProvider);
    final music = ref.watch(bgMusicProvider);
    final sfx = ref.watch(sfxProvider);
    return PopScope(
        canPop: false,
        child: GameWidget(
            overlayBuilderMap: {
              "PauseButton": (context, GameCore game) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    onPressed: () {
                      game.pauseEngine();
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MainButton(
                                icon: const Icon(Icons.play_arrow),
                                text: "Resume",
                                onPressed: () {
                                  game.resumeEngine();
                                  Navigator.pop(context);
                                },
                              ),
                              MainButton(
                                text: "Restart",
                                onPressed: () {
                                  game.closeGame();
                                  Navigator.pop(context);

                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => const GameScreen(),
                                  ));
                                },
                                icon: const Icon(Icons.restart_alt),
                              ),
                              MainButton(
                                icon: const Icon(Icons.exit_to_app),
                                text: "Exit",
                                onPressed: () {
                                  game.closeGame();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
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
            },
            game: GameCore(
              sfx: sfx,
              music: music,
              shake: shake,
            )));
  }
}
