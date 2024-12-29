import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'package:flame/parallax.dart';
import 'package:trials_of_valhalla/game_components/jump_button.dart';
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
    return super.onLoad();
  }
}
