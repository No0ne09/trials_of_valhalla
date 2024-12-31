import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:trials_of_valhalla/game_components/enemy.dart';
import 'package:trials_of_valhalla/game_components/game_core.dart';

import 'package:trials_of_valhalla/helpers/consts.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<GameCore> {
  bool _isJumping = false;
  bool _isAttacking = false;
  bool _jumpAttack = false;
  double _movement = 0;
  late double _gravity;
  late double _jumpStrength;
  late double _baseY;
  late final Image playerImage;
  late final RectangleHitbox _baseHitbox;
  late final RectangleHitbox _jumpHitbox;
  late final RectangleHitbox _attackHitbox;

  @override
  Future<void> onLoad() async {
    playerImage = await gameRef.images.load(characterPath);
    _setRunAnimation();
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
    _jumpStrength = size[0] / 35;
    _gravity = _jumpStrength / 90;
    _baseY = gameRef.size[1] - size[1];

    _attackHitbox = RectangleHitbox(
      position: Vector2(
        size[0] * 0.33,
        size[1] * 0.33,
      ),
      size: Vector2(
        size[0] * 0.43,
        size[1] * 0.52,
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) async {
    super.update(dt);
    //resetting y for rare cases when jump is ending too late and player ends under the map
    if (y > _baseY) {
      y = _baseY;
    }
    //if player _isJumping then its y is changing as long as it's higher or equal base y position
    if (_isJumping) {
      y += _movement;
      _movement += _gravity;
      //this check is needed for rare cases when attack and jump are ending at the same time and bad things are happening with hitbox managing
      if (!_isAttacking) {
        if (y >= _baseY) {
          _isJumping = false;
          _jumpAttack = false;
          y = _baseY;
          add(_jumpHitbox);
          remove(_jumpHitbox);
          add(_baseHitbox);
          _setRunAnimation();
        }
      }
    }
  }

  void _setRunAnimation() {
    SpriteSheet spriteSheet = SpriteSheet(
      image: playerImage,
      srcSize: Vector2(115, 84),
    );
    SpriteAnimation spriteAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: 0.1, from: 1, to: 8);
    animation = spriteAnimation;
  }

  void jump() {
    if (!_isJumping) {
      if (_isAttacking) {
        animationTicker?.setToLast();
      }
      remove(_baseHitbox);
      add(_jumpHitbox);
      _isJumping = true;
      _movement = -_jumpStrength;
      SpriteSheet spriteSheet = SpriteSheet(
        image: playerImage,
        srcSize: Vector2(115, 84),
      );
      SpriteAnimation spriteAnimation = spriteSheet.createAnimation(
          row: 19, stepTime: 0.3, from: 0, to: 4, loop: false);
      animation = spriteAnimation;
    }
  }

  void attack() {
    if (!_isAttacking) {
      add(_attackHitbox);
      _isAttacking = true;
      if (_isJumping && !_jumpAttack) {
        remove(_jumpHitbox);
        _jumpAttack = true;
      }

      SpriteSheet spriteSheet = SpriteSheet(
        image: playerImage,
        srcSize: Vector2(115, 84),
      );
      SpriteAnimation spriteAnimation = spriteSheet.createAnimation(
        row: 9,
        stepTime: 0.08,
        from: 0,
        to: 3,
        loop: false,
      );
      animation = spriteAnimation;

      animationTicker?.onComplete = () {
        _isAttacking = false;
        remove(_attackHitbox);
        add(_baseHitbox);
        _setRunAnimation();
      };
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemy) {
      if (other.isDead) {
      } else if (_isAttacking) {
        other.onHit();
        gameRef.score += 1;
      } else {
        //  print("collision with ${other.runtimeType}");
      }
    } else {
      // print("collision with ${other.runtimeType}");
    }
    super.onCollision(intersectionPoints, other);
  }
}
