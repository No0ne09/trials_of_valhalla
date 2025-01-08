import 'dart:async' as async;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:trials_of_valhalla/helpers/consts.dart';

enum EnemyType { bat, necro, draugr }

class Enemy extends SpriteAnimationComponent with HasGameRef {
  final EnemyType type;
  final double speed;

  Enemy({
    required this.type,
    required this.speed,
  });

  bool isDead = false;

  Future<void> _loadEnemy({
    required String path,
    required Vector2 srcSize,
    required int animationRow,
    required double animationStepTime,
    required int animationFrom,
    required int animationTo,
    required Vector2 sizeVector,
    required double positionYMultiplier,
    required Vector2 hitboxSizeMultiplier,
    required Vector2 hitboxPositionMultiplier,
  }) async {
    final startX = gameRef.size[0];
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load(path),
      srcSize: srcSize,
    );
    animation = spriteSheet.createAnimation(
      row: animationRow,
      stepTime: animationStepTime,
      from: animationFrom,
      to: animationTo,
    );
    size = sizeVector;
    position = Vector2(
      startX,
      gameRef.size[1] * positionYMultiplier,
    );
    add(
      RectangleHitbox(
        anchor: Anchor.center,
        size: Vector2(
          size[0] * hitboxSizeMultiplier.x,
          size[1] * hitboxSizeMultiplier.y,
        ),
        position: Vector2(
          size[0] * hitboxPositionMultiplier.x,
          size[1] * hitboxPositionMultiplier.y,
        ),
      ),
    );
  }

  @override
  async.FutureOr<void> onLoad() async {
    switch (type) {
      case EnemyType.bat:
        await _loadEnemy(
          path: enemyBatPath,
          srcSize: Vector2(
            64,
            64,
          ),
          animationRow: 0,
          animationStepTime: 0.05,
          animationFrom: 0,
          animationTo: 9,
          sizeVector: Vector2(
            gameRef.size[1] * 0.25,
            gameRef.size[1] * 0.25,
          ),
          positionYMultiplier: 0.33,
          hitboxPositionMultiplier: Vector2(0.5, 0.55),
          hitboxSizeMultiplier: Vector2(0.35, 0.35),
        );

      case EnemyType.necro:
        await _loadEnemy(
          path: enemyNecroPath,
          srcSize: Vector2(
            160,
            128,
          ),
          animationRow: 4,
          animationStepTime: 0.15,
          animationFrom: 0,
          animationTo: 17,
          sizeVector: Vector2(
            gameRef.size[0] / 1.5,
            gameRef.size[1] / 1.25,
          ),
          positionYMultiplier: 0.2,
          hitboxPositionMultiplier: Vector2(0.49, 0.7),
          hitboxSizeMultiplier: Vector2(0.18, 0.35),
        );

      case EnemyType.draugr:
        await _loadEnemy(
          path: enemyDraugrPath,
          srcSize: Vector2(
            80,
            80,
          ),
          animationRow: 1,
          animationStepTime: 0.18,
          animationFrom: 17,
          animationTo: 23,
          sizeVector: size = Vector2(
            gameRef.size[0] / 3,
            gameRef.size[1] / 2,
          ),
          positionYMultiplier: 0.5,
          hitboxSizeMultiplier: Vector2(
            0.45,
            0.25,
          ),
          hitboxPositionMultiplier: Vector2(
            0.55,
            0.65,
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
