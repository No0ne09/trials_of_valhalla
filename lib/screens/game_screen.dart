import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials_of_valhalla/game_components/game_core.dart';
import 'package:trials_of_valhalla/helpers/providers.dart';
import 'package:trials_of_valhalla/widgets/buttons/pause_button.dart';

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
              "PauseButton": (context, GameCore game) =>
                  PauseButton(game: game),
            },
            game: GameCore(
              sfx: sfx,
              music: music,
              shake: shake,
            )));
  }
}
