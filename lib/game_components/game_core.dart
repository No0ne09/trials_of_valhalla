import 'dart:async';
import 'dart:math';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'package:flame/parallax.dart';
import 'package:shake_detector/shake_detector.dart';

import 'package:trials_of_valhalla/game_components/enemy.dart';
import 'package:trials_of_valhalla/game_components/game_button_component.dart';
import 'package:trials_of_valhalla/game_components/player.dart';
import 'package:trials_of_valhalla/game_components/obstacle.dart';
import 'package:trials_of_valhalla/helpers/consts.dart';
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
    Flame.device.setPortraitUpOnly();
    FlameAudio.bgm.initialize();
    if (music) {
      FlameAudio.bgm.play("background/bg_music_${_random.nextInt(3) + 1}.mp3");
    }
    final player = Player(sfx: sfx);
    if (shake) {
      ShakeDetector.autoStart(
          onShake: () {
            player.attack();
          },
          shakeThresholdGravity: 1.1);
    }
    print(size);
    _scoreComponent = TextComponent(
      text: score.toString(),
      position: Vector2(size.x / 2, size.y - 50),
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 36,
          fontFamily: defaultFontFamily,
        ),
      ),
    );
    add(
      await loadParallaxComponent(
        [
          ParallaxImageData('parallax/1.png'),
          ParallaxImageData('parallax/2.png'),
          ParallaxImageData('parallax/3.png'),
          ParallaxImageData('parallax/4.png'),
        ],
        baseVelocity: Vector2(10, 0),
        velocityMultiplierDelta: Vector2(1.4, 0),
      ),
    );
    add(player);
    add(
      await loadParallaxComponent(
        [
          ParallaxImageData('parallax/5.png'),
        ],
        baseVelocity: Vector2(10, 0),
        velocityMultiplierDelta: Vector2(1, 0),
      ),
    );
    add(
      GameButtonComponent(
        onTap: player.jump,
        buttonPosition: Vector2(
          size[0] * 0.05,
          size[1] * 0.05,
        ),
        path: jumpButtonPath,
      ),
    );
    add(
      GameButtonComponent(
        onTap: player.attack,
        buttonPosition: Vector2(
          size[0] * 0.87,
          size[1] * 0.05,
        ),
        path: attackButtonPath,
      ),
    );
    add(_scoreComponent);
    overlays.add("PauseButton");
    // add(FpsTextComponent(position: Vector2(0, 0)));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    score = 100;
    _scoreComponent.text = score.toString();
    _enemyTimerPeriod = max(0.8, 5.0 - score * 0.05);
    _enemyTimer += dt;
    _obstacleTimerPeriod = max(5, 12.0 - score * 0.07);
    _obstacleTimer += dt;
    if (_obstacleTimer >= _obstacleTimerPeriod) {
      final obstacle = Obstacle(
        speed: 3 + min(4.4, score * 0.1),
      );
      _obstacleTimer = 0;
      add(obstacle);
    }
    if (_enemyTimer >= _enemyTimerPeriod) {
      final enemy = Enemy(
        type: EnemyType.values[_random.nextInt(EnemyType.values.length)],
        speed: 2 + min(3.5, score * 0.07),
        positionModifier: _random.nextDouble() * size[0] / 3,
      );
      _enemyTimer = 0;
      add(enemy);
    }

    super.update(dt);
  }

  void closeGame() {
    FlameAudio.bgm.stop();
  }
}
