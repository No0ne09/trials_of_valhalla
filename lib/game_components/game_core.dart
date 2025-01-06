import 'dart:async';
import 'dart:math';
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
  final double threshold;
  GameCore({
    required this.sfx,
    required this.music,
    required this.shake,
    required this.threshold,
  });

  double _enemyTimer = 0;
  double _obstacleTimer = 0;
  int score = 0;
  late TextComponent _scoreComponent;
  late ShakeDetector _detector;
  final _random = Random();
  @override
  FutureOr<void> onLoad() async {
    //debugMode = true;
    FlameAudio.bgm.initialize();
    if (music) {
      FlameAudio.bgm.play("background/bg_music_${_random.nextInt(3) + 1}.mp3");
    }
    final player = Player(sfx: sfx);
    if (shake) {
      _detector = ShakeDetector.autoStart(
          onShake: () {
            player.attack();
          },
          shakeThresholdGravity: threshold);
    }

    _scoreComponent = TextComponent(
      text: score.toString(),
      position: Vector2(
        size.x / 2,
        size.y - 50,
      ),
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
        baseVelocity: Vector2(
          10,
          0,
        ),
        velocityMultiplierDelta: Vector2(
          1.4,
          0,
        ),
      ),
    );
    add(player);
    add(
      await loadParallaxComponent(
        [
          ParallaxImageData('parallax/5.png'),
        ],
        baseVelocity: Vector2(
          10,
          0,
        ),
        velocityMultiplierDelta: Vector2(
          1,
          0,
        ),
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
          size[0] * 0.85,
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
    _scoreComponent.text = score.toString();
    final enemySpawnRate = max(0.9, 4.9 - score * 0.04);
    _enemyTimer += dt;
    final obstacleSpawnRate = max(5, 12.0 - score * 0.07);
    _obstacleTimer += dt;
    if (_obstacleTimer >= obstacleSpawnRate) {
      final obstacle = Obstacle(
        speed: (4 + min(4.4, score * 0.1)) * size[0] / 13,
      );
      _obstacleTimer = 0;
      add(obstacle);
    }
    if (_enemyTimer >= enemySpawnRate) {
      final enemy = Enemy(
        type: EnemyType.values[_random.nextInt(EnemyType.values.length)],
        speed: (3 + min(3.5, score * 0.07)) * size[0] / 15,
        positionModifier: _random.nextDouble() * size[0] / 13,
      );
      _enemyTimer = 0;
      add(enemy);
    }

    super.update(dt);
  }

  void closeGame() {
    if (shake) _detector.pauseListening();
    pauseEngine();
    FlameAudio.bgm.stop();
  }
}
