import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'package:flame/parallax.dart';
import 'package:trials_of_valhalla/game_components/attack_button.dart';
import 'package:trials_of_valhalla/game_components/enemy.dart';
import 'package:trials_of_valhalla/game_components/jump_button.dart';
import 'package:trials_of_valhalla/game_components/player.dart';
import 'package:trials_of_valhalla/game_components/obstacle.dart';

class GameCore extends FlameGame with HasCollisionDetection {
  late double _enemyTimerPeriod;
  late double _obstacleTimerPeriod;
  double _enemyTimer = 0;
  double _obstacleTimer = 0;
  @override
  FutureOr<void> onLoad() async {
    final parallaxBackground = await loadParallaxComponent(
      [
        ParallaxImageData('parallax/1.png'),
        ParallaxImageData('parallax/2.png'),
        ParallaxImageData('parallax/3.png'),
        ParallaxImageData('parallax/4.png'),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.4, 0),
    );
    add(parallaxBackground);
    final player = Player();

    add(player);

    final parallaxBackground2 = await loadParallaxComponent(
      [
        ParallaxImageData('parallax/5.png'),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1, 0),
    );
    add(parallaxBackground2);
    add(JumpButton(player));
    add(AttackButton(player));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _enemyTimerPeriod = max(1.0, 1.0);
    _enemyTimer += dt;
    _obstacleTimerPeriod = max(2.0, 2.0);
    _obstacleTimer += dt;
    if (_obstacleTimer >= _obstacleTimerPeriod) {
      final obstacle = Obstacle();
      _obstacleTimer = 0;
      add(obstacle);
    }
    if (_enemyTimer >= _enemyTimerPeriod) {
      final enemy = Enemy(type: EnemyType.bat);
      _enemyTimer = 0;
      add(enemy);
    }
    super.update(dt);
  }
}
