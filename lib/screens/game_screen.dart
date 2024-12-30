import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:trials_of_valhalla/game_components/game_core.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(canPop: false, child: GameWidget(game: GameCore()));
  }
}
