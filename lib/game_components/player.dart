import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:trials_of_valhalla/helpers/consts.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  bool _isJumping = false;
  bool _isAttacking = false;
  double _movement = 0;
  late double _gravity;
  late double _jumpStrength;
  late double _baseY;
  late final RectangleHitbox _baseHitbox;
  late final RectangleHitbox _jumpHitbox;
  late final RectangleHitbox _attackHitbox;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _setRunAnimation();

    size = Vector2(gameRef.size[1] / 2, gameRef.size[1] / 2);
    position = Vector2(0, gameRef.size[1] - size[1]);

    _baseHitbox = RectangleHitbox(
      position: Vector2(
        size[0] * 0.35,
        size[1] * 0.33,
      ),
      size: Vector2(
        size[0] * 0.32,
        size[1] * 0.52,
      ),
    );
    add(_baseHitbox);
    debugMode = true;

    _jumpHitbox = RectangleHitbox(
      position: Vector2(
        size[0] * 0.3,
        size[1] * 0.2,
      ),
      size: Vector2(
        size[0] * 0.3,
        size[1] * 0.45,
      ),
    );
    _jumpStrength = size[0] / 20;
    _gravity = _jumpStrength / 50;
    _baseY = gameRef.size[1] - size[1];

    _attackHitbox = RectangleHitbox(
      position: Vector2(
        size[0] * 0.35,
        size[1] * 0.33,
      ),
      size: Vector2(
        size[0] * 0.4,
        size[1] * 0.52,
      ),
    );
  }

  @override
  void update(double dt) async {
    super.update(dt);
    //resetting y for rare cases when jump is ending too
    if (y >= _baseY) {
      y = _baseY;
    }
    //if player _isJumping then its y is changing as long as it's higher or equal base y position
    if (_isJumping) {
      y += _movement;
      _movement += _gravity;
      if (y >= _baseY) {
        _isJumping = false;
        y = _baseY;
        remove(_jumpHitbox);
        add(_baseHitbox);
        await _setRunAnimation();
      }
    }
  }

  Future<void> _setRunAnimation() async {
    SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(characterPath),
      srcSize: Vector2(115, 84),
    );
    SpriteAnimation spriteAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: 0.1, from: 1, to: 8);
    animation = spriteAnimation;
  }

  void jump() async {
    if (!_isJumping) {
      remove(_baseHitbox);
      add(_jumpHitbox);
      _isJumping = true;
      _movement = -_jumpStrength;
      SpriteSheet spriteSheet = SpriteSheet(
        image: await gameRef.images.load(characterPath),
        srcSize: Vector2(115, 84),
      );
      SpriteAnimation spriteAnimation = spriteSheet.createAnimation(
          row: 19, stepTime: 0.3, from: 0, to: 4, loop: false);

      animation = spriteAnimation;
    }
  }

  Future<void> attack() async {
    if (!_isAttacking) {
      remove(_baseHitbox);

      add(_attackHitbox);
      SpriteSheet spriteSheet = SpriteSheet(
        image: await gameRef.images.load(characterPath),
        srcSize: Vector2(115, 84),
      );
      SpriteAnimation spriteAnimation = spriteSheet.createAnimation(
        row: 9,
        stepTime: 0.05,
        from: 0,
        to: 3,
        loop: false,
      );
      animation = spriteAnimation;
      _isAttacking = true;
      animationTicker!.onComplete = () async {
        _isAttacking = false;
        remove(_attackHitbox);
        add(_baseHitbox);
        await _setRunAnimation();
      };
    }
  }
}
