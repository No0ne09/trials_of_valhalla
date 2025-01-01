import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials_of_valhalla/helpers/consts.dart';

final shakeProvider = StateProvider<bool>(
  (ref) => true,
);

final bgMusicProvider = StateProvider<bool>(
  (ref) => true,
);
final sfxProvider = StateProvider<bool>(
  (ref) => true,
);

final thresholdProvider = StateProvider<double>(
  (ref) => baseThreshold,
);
