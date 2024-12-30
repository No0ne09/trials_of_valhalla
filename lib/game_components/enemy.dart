import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

enum EnemyType { bat, necro }

class Enemy extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  final EnemyType type;

  Enemy({required this.type});

  @override
  FutureOr<void> onLoad() async {
    final SpriteSheet spriteSheet;
    switch (type) {
      case EnemyType.bat:
        spriteSheet = SpriteSheet(
          image: await gameRef.images.load('game_images/enemy_bat.png'),
          srcSize: Vector2(64, 64),
        );
        SpriteAnimation spriteAnimation =
            spriteSheet.createAnimation(row: 0, stepTime: 0.07, from: 0, to: 9);
        animation = spriteAnimation;
        size = Vector2(gameRef.size[1] * 0.25, gameRef.size[1] * 0.25);
        position = Vector2(gameRef.size[0] - size[0], gameRef.size[1] * 0.33);
        add(
          RectangleHitbox(
            anchor: Anchor.center,
            position: Vector2(size[0] * 0.5, size[1] * 0.55),
            size: Vector2(size[0] * 0.52, size[1] * 0.51),
          ),
        );

      case EnemyType.necro:
        spriteSheet = SpriteSheet(
          image: await gameRef.images.load('game_images/enemy_necro.png'),
          srcSize: Vector2(160, 128),
        );
        SpriteAnimation spriteAnimation = spriteSheet.createAnimation(
          row: 2,
          stepTime: 0.15,
          from: 5,
          to: 17,
        );
        animation = spriteAnimation;
        size = Vector2(gameRef.size[0] / 1.5, gameRef.size[1] / 1.25);
        position = Vector2(gameRef.size[0] - size[0], gameRef.size[1] / 5);
        add(
          RectangleHitbox(
            anchor: Anchor.center,
            position: Vector2(size[0] * 0.49, size[1] * 0.6),
            size: Vector2(size[0] * 0.25, size[1] * 0.55),
          ),
        );
    }

    debugMode = true;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    x -= 2;
    if (x <= -size.x) {
      removeFromParent();
    }
    super.update(dt);
  }

  void onHit() {
    print("hit");
  }
}
