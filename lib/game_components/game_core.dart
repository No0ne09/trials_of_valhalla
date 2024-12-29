import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'package:flame/parallax.dart';
import 'package:trials_of_valhalla/game_components/player.dart';

class GameCore extends FlameGame with HasCollisionDetection {
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
    add(Player(gameSize: size)
      ..anchor = Anchor.bottomLeft
      ..x = -50
      ..y = size[1] - 20);

    final parallaxBackground2 = await loadParallaxComponent(
      [
        ParallaxImageData('parallax/5.png'),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1, 0),
    );
    add(parallaxBackground2);
    return super.onLoad();
  }
}
