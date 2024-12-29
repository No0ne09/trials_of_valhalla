import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  Player({
    required this.gameSize,
  }) : super(size: Vector2(gameSize[1] / 2, gameSize[1] / 2));
  final Vector2 gameSize;

  Future<void> runAnimation() async {
    SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load("game_images/character.png"),
      srcSize: Vector2(115, 84),
    );
    SpriteAnimation spriteAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: 0.1, from: 1, to: 8);
    animation = spriteAnimation;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await runAnimation();
    final baseHitBox = RectangleHitbox(
      position: Vector2(
        size[0] * 0.35,
        size[1] * 0.33,
      ),
      size: Vector2(
        size[0] * 0.32,
        size[1] * 0.52,
      ),
    );
    add(baseHitBox);
    print(gameSize);
    print(size);
    debugMode = true;
  }
}
