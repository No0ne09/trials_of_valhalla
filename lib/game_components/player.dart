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
      image: await gameRef.images.load(
        characterPath,
      ),
      srcSize: Vector2(
        115,
        84,
      ),
    );
    size = Vector2(
      gameRef.size[1] / 2,
      gameRef.size[1] / 2,
    );
    position = Vector2(
      0,
      gameRef.size[1] - size[1],
    );
    _runAnimation = spriteSheet.createAnimation(
      row: 2,
      stepTime: 0.1,
      from: 1,
      to: 8,
    );
    _jumpAnimation = spriteSheet.createAnimation(
      row: 19,
      stepTime: 0.3,
      from: 0,
      to: 4,
      loop: false,
    );
    _attackAnimation = spriteSheet.createAnimation(
      row: 9,
      stepTime: 0.07,
      from: 0,
      to: 3,
      loop: false,
    );
    animation = _runAnimation;
    _runHitbox = RectangleHitbox(
      position: Vector2(
        size[0] * 0.42,
        size[1] * 0.35,
      ),
      size: Vector2(
        size[0] * 0.2,
        size[1] * 0.46,
      ),
    );
    add(_runHitbox);

    _jumpHitbox = RectangleHitbox(
      position: Vector2(
        size[0] * 0.32,
        size[1] * 0.15,
      ),
      size: Vector2(
        size[0] * 0.22,
        size[1] * 0.35,
      ),
    );
    _jumpStrength = size[0] * 2;
    _baseY = gameRef.size[1] - size[1];
    _attackHitbox = RectangleHitbox(
      position: Vector2(
        size[0] * 0.33,
        size[1] * 0.35,
      ),
      size: Vector2(
        size[0] * 0.4,
        size[1] * 0.46,
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
      _movement += _jumpStrength * dt;
      y += _movement * dt;

      //this check is needed for rare cases when attack and jump are ending at the same time and bad things are happening with hitbox managing
      if (!_isAttacking && y >= _baseY) {
        y = _baseY;
        add(_jumpHitbox);
        remove(_jumpHitbox);
        add(_runHitbox);
        animation = _runAnimation;
        _isJumping = false;
        _jumpAttack = false;
      }
    }
  }

  void jump() {
    if (!_isJumping) {
      _isJumping = true;
      if (sfx) playSFX(jumpSfxPath);
      if (_isAttacking) {
        animationTicker?.setToLast();
      }
      remove(_runHitbox);
      add(_jumpHitbox);
      _movement = -_jumpStrength;
      animation = _jumpAnimation;
    }
  }

  void attack() {
    if (!_isAttacking) {
      _isAttacking = true;
      add(_attackHitbox);
      if (sfx) playSFX(attackSfxPath);
      if (_isJumping && !_jumpAttack) {
        remove(_jumpHitbox);
        _jumpAttack = true;
      }

      animation = _attackAnimation;

      animationTicker?.onComplete = () {
        remove(_attackHitbox);
        add(_runHitbox);
        animation = _runAnimation;
        _isAttacking = false;
      };
    }
  }

//I KNOW IT'S UGLY BUT IT'S ONE OF THOSE FUNCTIONS THAT DON'T WANT TO WORK ANY OTHER WAY
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemy) {
      if (!other.isDead) {
        if (_isAttacking) {
          other.onHit();
          gameRef.score += 1;
          if (sfx) playSFX(enemyDeathSfxPath);
        } else {
          _updateOverlays();
          //gameRef.pauseEngine();
        }
      }
    } else {
      _updateOverlays();
      //gameRef.pauseEngine();
    }
    super.onCollision(intersectionPoints, other);
  }

  void _updateOverlays() {
    game.overlays.remove("PauseButton");
    gameRef.overlays.add("GameOver");
  }
}
