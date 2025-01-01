/*Wolf is more like obstacle not enemy 
so it is seperated from standard enemies*/

import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:trials_of_valhalla/game_components/game_core.dart';
import 'package:trials_of_valhalla/helpers/consts.dart';

class Obstacle extends SpriteAnimationComponent
    with HasGameRef<GameCore>, CollisionCallbacks {
  final double speed;
  Obstacle({required this.speed});
  @override
  FutureOr<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load(obstacleWolfPath),
      srcSize: Vector2(
        48,
        32,
      ),
    );
    SpriteAnimation spriteAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.15,
      from: 1,
      to: 6,
    );
    animation = spriteAnimation;
    size = Vector2(
      gameRef.size[0] * 0.18,
      gameRef.size[1] * 0.18,
    );
    position = Vector2(
      gameRef.size[0],
      gameRef.size[1] * 0.75,
    );
    add(
      RectangleHitbox(
        anchor: Anchor.center,
        size: Vector2(
          size[0] * 0.65,
          size[1] * 0.65,
        ),
        position: Vector2(
          size[0] * 0.65,
          size[1] * 0.65,
        ),
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    x -= speed * dt;
    if (x <= -size.x) {
      gameRef.score += 1;
      removeFromParent();
    }
    super.update(dt);
  }
}
