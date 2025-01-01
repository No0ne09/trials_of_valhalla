import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'dart:async' as async;

class GameButtonComponent extends SpriteComponent
    with TapCallbacks, HasGameRef {
  final Vector2 buttonPosition;
  final String path;
  final void Function() onTap;
  GameButtonComponent({
    required this.buttonPosition,
    required this.onTap,
    required this.path,
  });

  @override
  Future<void> onLoad() async {
    size = Vector2(
      gameRef.size[1] / 6,
      gameRef.size[1] / 6,
    );
    position = buttonPosition;
    sprite = await Sprite.load(path);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) async {
    onTap();
    async.Timer.periodic(const Duration(milliseconds: 50), (timer) {
      double tempOpacity = opacity - 0.20;
      if (tempOpacity <= 0.5) {
        tempOpacity = 1;
        opacity = 1;
        timer.cancel();
      }
      opacity = tempOpacity;
    });

    super.onTapDown(event);
  }
}
