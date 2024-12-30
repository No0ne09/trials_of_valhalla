import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/game_components/player.dart';

class AttackButton extends PositionComponent with TapCallbacks, HasGameRef {
  final Player character;

  AttackButton(this.character);

  @override
  Future<void> onLoad() async {
    size = Vector2(50, 50);
    position = Vector2(gameRef.size[0] - 50, gameRef.size[1] - 50);
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.red,
    ));
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    character.attack();

    super.onTapDown(event);
  }
}
