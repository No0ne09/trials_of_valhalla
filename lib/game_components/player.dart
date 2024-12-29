import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  bool isJumping = false;
  double movement = 0;
  late double gravity;
  late double jumpStrength;
  late double baseY;
  late final RectangleHitbox baseHitbox;
  late final RectangleHitbox jumpHitbox;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await setRunAnimation();

    size = Vector2(gameRef.size[1] / 2, gameRef.size[1] / 2);
    position = Vector2(0, gameRef.size[1] - size[1]);

    baseHitbox = RectangleHitbox(
      position: Vector2(
        size[0] * 0.35,
        size[1] * 0.33,
      ),
      size: Vector2(
        size[0] * 0.32,
        size[1] * 0.52,
      ),
    );
    add(baseHitbox);
    debugMode = true;

    jumpHitbox = RectangleHitbox(
      position: Vector2(
        size[0] * 0.3,
        size[1] * 0.2,
      ),
      size: Vector2(
        size[0] * 0.3,
        size[1] * 0.45,
      ),
    );
    jumpStrength = size[0] / 20;
    gravity = jumpStrength / 50;
    baseY = gameRef.size[1] - size[1];
  }

  @override
  void update(double dt) async {
    super.update(dt);
    //resetting y for rare cases when jump is ending too
    if (y >= baseY) {
      y = baseY;
    }
    //if player isjumping then its y is changing as long as it's higher or equal base y position
    if (isJumping) {
      y += movement;
      movement += gravity;
      if (y >= baseY) {
        isJumping = false;
        y = baseY;
        add(jumpHitbox);
        remove(jumpHitbox);
        add(baseHitbox);
        await setRunAnimation();
      }
    }
  }

  Future<void> setRunAnimation() async {
    SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load("game_images/character.png"),
      srcSize: Vector2(115, 84),
    );
    SpriteAnimation spriteAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: 0.1, from: 1, to: 8);
    animation = spriteAnimation;
  }

  void jump() async {
    if (!isJumping) {
      remove(baseHitbox);
      add(jumpHitbox);
      isJumping = true;
      movement = -jumpStrength;
      SpriteSheet spriteSheet = SpriteSheet(
        image: await gameRef.images.load("game_images/character.png"),
        srcSize: Vector2(115, 84),
      );
      SpriteAnimation spriteAnimation = spriteSheet.createAnimation(
          row: 19, stepTime: 0.3, from: 0, to: 4, loop: false);

      animation = spriteAnimation;
    }
  }
}
