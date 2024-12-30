import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Enemy extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  @override
  FutureOr<void> onLoad() async {
    SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load('game_images/enemy_bat.png'),
      srcSize: Vector2(64, 64),
    );
    SpriteAnimation spriteAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.07, from: 0, to: 9);
    animation = spriteAnimation;
    size = Vector2(gameRef.size[1] / 4, gameRef.size[1] / 4);
    position = Vector2(gameRef.size[0] - size[0], gameRef.size[1] / 3);
    add(RectangleHitbox(
        anchor: Anchor.center,
        position: Vector2(size[0] / 2, size[1] * 0.55),
        size: Vector2(size[0] * 0.52, size[1] * 0.51)));
    debugMode = true;
    return super.onLoad();
  }
}
