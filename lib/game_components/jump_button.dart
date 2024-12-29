import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/game_components/player.dart';

class JumpButton extends PositionComponent with TapCallbacks, HasGameRef {
  final Player player;

  JumpButton(this.player);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(50, 50);
    position = Vector2(20, 100);
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.blue,
    ));
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.jump();
    super.onTapDown(event);
  }
}
