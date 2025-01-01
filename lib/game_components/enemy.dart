import 'dart:async' as async;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:trials_of_valhalla/helpers/consts.dart';

enum EnemyType { bat, necro, draugr }

class Enemy extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  final EnemyType type;
  final double speed;
  final double positionModifier;

  Enemy({
    required this.type,
    required this.speed,
    required this.positionModifier,
  });
  bool isDead = false;
  @override
  async.FutureOr<void> onLoad() async {
    final startX = gameRef.size[0] + size[0] + positionModifier;
    final SpriteSheet spriteSheet;
    switch (type) {
      case EnemyType.bat:
        spriteSheet = SpriteSheet(
          image: await gameRef.images.load(enemyBatPath),
          srcSize: Vector2(64, 64),
        );
        SpriteAnimation spriteAnimation = spriteSheet.createAnimation(
          row: 0,
          stepTime: 0.05,
          from: 0,
          to: 9,
        );
        animation = spriteAnimation;
        size = Vector2(
          gameRef.size[1] * 0.25,
          gameRef.size[1] * 0.25,
        );
        position = Vector2(startX, gameRef.size[1] * 0.33);
        add(
          RectangleHitbox(
            anchor: Anchor.center,
            size: Vector2(size[0] * 0.52, size[1] * 0.51),
            position: Vector2(size[0] * 0.5, size[1] * 0.55),
          ),
        );

      case EnemyType.necro:
        spriteSheet = SpriteSheet(
          image: await gameRef.images.load(enemyNecroPath),
          srcSize: Vector2(160, 128),
        );
        SpriteAnimation spriteAnimation = spriteSheet.createAnimation(
          row: 4,
          stepTime: 0.15,
          from: 0,
          to: 17,
        );
        animation = spriteAnimation;
        size = Vector2(gameRef.size[0] / 1.5, gameRef.size[1] / 1.25);
        position = Vector2(startX, gameRef.size[1] / 5);
        add(
          RectangleHitbox(
            anchor: Anchor.center,
            size: Vector2(size[0] * 0.18, size[1] * 0.4),
            position: Vector2(size[0] * 0.49, size[1] * 0.7),
          ),
        );
      case EnemyType.draugr:
        spriteSheet = SpriteSheet(
          image: await gameRef.images.load(enemyDraugrPath),
          srcSize: Vector2(80, 80),
        );
        SpriteAnimation spriteAnimation = spriteSheet.createAnimation(
          row: 1,
          stepTime: 0.1,
          from: 17,
          to: 23,
        );
        animation = spriteAnimation;
        size = Vector2(gameRef.size[0] / 3, gameRef.size[1] / 2);
        position = Vector2(startX, gameRef.size[1] * 0.5);

        add(
          RectangleHitbox(
            anchor: Anchor.center,
            size: Vector2(size[0] * 0.45, size[1] * 0.25),
            position: Vector2(size[0] * 0.52, size[1] * 0.65),
          ),
        );
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    x -= speed * dt;
    if (x <= -size.x) {
      removeFromParent();
    }
    super.update(dt);
  }

  void onHit() {
    isDead = true;
    async.Timer.periodic(const Duration(milliseconds: 50), (timer) {
      double tempOpacity = opacity - 0.15;
      if (tempOpacity <= 0) {
        tempOpacity = 0;
        opacity = 0;
        removeFromParent();
        timer.cancel();
      }

      opacity = tempOpacity;
    });
  }
}
