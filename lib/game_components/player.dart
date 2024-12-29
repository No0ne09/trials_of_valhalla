import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  Player({
    required this.gameSize,
  }) : super(size: Vector2(3 * 96, 3 * 96));
  final Vector2 gameSize;

  final baseHitBox = RectangleHitbox(
      anchor: Anchor.center,
      position: Vector2(150, 170),
      size: Vector2(90, 150));

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
    add(baseHitBox);
    debugMode = true;
  }
}
