import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class GameButton extends SpriteComponent with TapCallbacks, HasGameRef {
  final Vector2 buttonPosition;
  final Color color;
  final void Function() onTap;
  GameButton({
    required this.buttonPosition,
    required this.color,
    required this.onTap,
  });

  @override
  Future<void> onLoad() async {
    size = Vector2(gameRef.size[1] / 8, gameRef.size[1] / 8);
    position = buttonPosition;

    sprite = await Sprite.load('buttons/jump_button.png');
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap();
    paint = Paint()..color = Colors.yellow;
    onTap();

    super.onTapDown(event);
  }
}
