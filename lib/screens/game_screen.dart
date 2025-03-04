import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials_of_valhalla/game_components/game_core.dart';
import 'package:trials_of_valhalla/helpers/consts.dart';
import 'package:trials_of_valhalla/helpers/functions.dart';
import 'package:trials_of_valhalla/helpers/providers.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/widgets/buttons/pause_button.dart';
import 'package:trials_of_valhalla/screens/complex_screen_base.dart';
import 'package:trials_of_valhalla/widgets/popups/game_overaly_popup.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  void _uploadScore(int score, BuildContext context) {
    try {
      FirebaseFirestore.instance.collection("high_scores").doc().set({
        "user": FirebaseAuth.instance.currentUser!.email,
        "score": score,
      });
    } on FirebaseException catch (e) {
      if (context.mounted) return;
      handleFirebaseError(e.code, context);
      return;
    } catch (_) {
      if (!context.mounted) return;
      showInfoPopup(context, unknownError);
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    final shake = ref.watch(shakeProvider);
    final music = ref.watch(bgMusicProvider);
    final sfx = ref.watch(sfxProvider);
    final threshold = ref.watch(thresholdProvider);
    return PopScope(
      canPop: false,
      child: GameWidget(
        overlayBuilderMap: {
          "PauseButton": (context, GameCore game) => PauseButton(game: game),
          "GameOver": (context, GameCore game) {
            if (game.score > 0) _uploadScore(game.score, context);
            game.closeGame();
            if (sfx) playSFX(playerDeathSfxPath);
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
            return ComplexScreenBase(
              title: gameOver,
              divider: 1,
              child: GameOveralyPopup(
                game: game,
                isGameOver: true,
                score: game.score,
              ),
            );
          },
        },
        game: GameCore(
          sfx: sfx,
          music: music,
          shake: shake,
          threshold: threshold,
        ),
      ),
    );
  }
}
