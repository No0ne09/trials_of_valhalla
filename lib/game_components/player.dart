import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:trials_of_valhalla/game_components/enemy.dart';
import 'package:trials_of_valhalla/game_components/game_core.dart';

import 'package:trials_of_valhalla/helpers/consts.dart';
import 'package:trials_of_valhalla/helpers/functions.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<GameCore> {
  final bool sfx;
  Player({required this.sfx});
  bool _isJumping = false;
  bool _isAttacking = false;
  bool _jumpAttack = false;
  double _movement = 0;
  late double _gravity;
  late double _jumpStrength;
  late double _baseY;
  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _jumpAnimation;
  late final SpriteAnimation _attackAnimation;
  late final RectangleHitbox _runHitbox;
  late final RectangleHitbox _jumpHitbox;
  late final RectangleHitbox _attackHitbox;

  @override
  Future<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load(characterPath),
      srcSize: Vector2(115, 84),
    );
    _runAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: 0.1, from: 1, to: 8);
    _jumpAnimation = spriteSheet.createAnimation(
        row: 19, stepTime: 0.3, from: 0, to: 4, loop: false);
    _attackAnimation = spriteSheet.createAnimation(
      row: 9,
      stepTime: 0.08,
      from: 0,
      to: 3,
      loop: false,
    );
    size = Vector2(gameRef.size[1] / 2, gameRef.size[1] / 2);
    position = Vector2(0, gameRef.size[1] - size[1]);
    animation = _runAnimation;
    _runHitbox = RectangleHitbox(
      position: Vector2(
        size[0] * 0.35,
        size[1] * 0.33,
      ),
      size: Vector2(
        size[0] * 0.32,
        size[1] * 0.52,
      ),
    );
    add(_runHitbox);
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
          add(_runHitbox);
          animation = _runAnimation;
        }
      }
    }
  }

  void jump() {
    if (!_isJumping) {
      if (sfx) playSFX(jumpSfxPath);
      if (_isAttacking) {
        animationTicker?.setToLast();
      }
      remove(_runHitbox);
      add(_jumpHitbox);
      _isJumping = true;
      _movement = -_jumpStrength;
      animation = _jumpAnimation;
    }
  }

  void attack() {
    if (!_isAttacking) {
      if (sfx) playSFX(attackSfxPath);
      add(_attackHitbox);
      _isAttacking = true;
      if (_isJumping && !_jumpAttack) {
        remove(_jumpHitbox);
        _jumpAttack = true;
      }

      animation = _attackAnimation;

      animationTicker?.onComplete = () {
        _isAttacking = false;
        remove(_attackHitbox);
        add(_runHitbox);
        animation = _runAnimation;
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
