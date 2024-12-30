/*Wolf is more like obstacle not enemy 
so it is seperated from standard enemies*/

import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:trials_of_valhalla/game_components/game_core.dart';

class Obstacle extends SpriteAnimationComponent
    with HasGameRef<GameCore>, CollisionCallbacks {
  @override
  FutureOr<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('game_images/enemy_wolf.png'),
      srcSize: Vector2(32, 32),
    );
    SpriteAnimation spriteAnimation = spriteSheet.createAnimation(
      row: 2,
      stepTime: 0.15,
      from: 6,
      to: 10,
    );
    animation = spriteAnimation;
    size = Vector2(gameRef.size[0] * 0.15, gameRef.size[1] * 0.3);
    position = Vector2(gameRef.size[0] - size[0], gameRef.size[1] * 0.6);
    add(RectangleHitbox(
      anchor: Anchor.center,
      position: Vector2(size[0] * 0.5, size[1] * 0.7),
      size: Vector2(size[0] * 0.8, size[1] * 0.55),
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    x -= 2;
    if (x <= -size.x) {
      gameRef.score += 1;
      removeFromParent();
    }
    super.update(dt);
  }
}
