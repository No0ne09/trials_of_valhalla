import 'dart:async';
import 'dart:math';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'package:flame/parallax.dart';
import 'package:trials_of_valhalla/game_components/attack_button.dart';
import 'package:trials_of_valhalla/game_components/enemy.dart';
import 'package:trials_of_valhalla/game_components/jump_button.dart';
import 'package:trials_of_valhalla/game_components/player.dart';
import 'package:trials_of_valhalla/game_components/obstacle.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';

class GameCore extends FlameGame with HasCollisionDetection {
  final bool sfx;
  final bool music;
  final bool shake;
  GameCore({
    required this.sfx,
    required this.music,
    required this.shake,
  });

  late double _enemyTimerPeriod;
  late double _obstacleTimerPeriod;
  double _enemyTimer = 0;
  double _obstacleTimer = 0;
  int score = 0;
  late TextComponent _scoreComponent;
  final _random = Random();
  @override
  FutureOr<void> onLoad() async {
    Flame.device.fullScreen();
    if (music) {
      FlameAudio.bgm.initialize();
      FlameAudio.bgm.play("background/bg_music_${_random.nextInt(3)}.mp3");
    }
    _scoreComponent = TextComponent(
      text: score.toString(),
      position: Vector2(size.x / 2, 10),
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 36,
          fontFamily: defaultFontFamily,
        ),
      ),
    );
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
    final player = Player(sfx: sfx);

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
    add(_scoreComponent);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _scoreComponent.text = score.toString();
    _enemyTimerPeriod = max(1, 5.0 - score * 0.04);
    _enemyTimer += dt;
    _obstacleTimerPeriod = max(3.5, 10.0 - score * 0.065);
    _obstacleTimer += dt;
    if (_obstacleTimer >= _obstacleTimerPeriod) {
      final obstacle = Obstacle(
        speed: 3 + min(4.0, score * 0.08),
      );
      _obstacleTimer = 0;
      add(obstacle);
    }
    if (_enemyTimer >= _enemyTimerPeriod) {
      final enemy = Enemy(
        type: EnemyType.values[_random.nextInt(EnemyType.values.length)],
        speed: 2 + min(3.0, score * 0.05),
        positionModifier: _random.nextDouble() * size[0] / 3,
        sfx: sfx,
      );
      _enemyTimer = 0;
      add(enemy);
    }
    super.update(dt);
  }
}
