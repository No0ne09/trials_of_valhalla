import 'package:flutter_riverpod/flutter_riverpod.dart';

final shakeProvider = StateProvider<bool>(
  (ref) => true,
);

final bgMusicProvider = StateProvider<bool>(
  (ref) => true,
);
final sfxProvider = StateProvider<bool>(
  (ref) => true,
);
