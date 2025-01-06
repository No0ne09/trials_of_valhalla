import 'package:trials_of_valhalla/helpers/strings.dart';

const characterPath = 'game_images/character.png';
const buttonSFXPath = 'assets/audio/sfx/button.wav';
const enemyDeathSfxPath = 'assets/audio/sfx/enemy.wav';
const attackSfxPath = 'assets/audio/sfx/attack.wav';
const jumpSfxPath = 'assets/audio/sfx/jump.wav';
const playerDeathSfxPath = 'assets/audio/sfx/death.wav';
const logoPath = 'assets/images/logo.png';
const jumpButtonPath = 'buttons/jump_button.png';
const attackButtonPath = 'buttons/attack_button.png';
const obstacleWolfPath = "game_images/obstacle_wolf.png";
const enemyBatPath = 'game_images/enemy_bat.png';
const enemyNecroPath = 'game_images/enemy_necro.png';
const enemyDraugrPath = 'game_images/enemy_draugr.png';

const baseThreshold = 1.2;
const Map<String, double> thresholdsOptions = {
  minimum: 1.01,
  extremelyLow: 1.02,
  veryLow: 1.05,
  low: 1.1,
  medium: baseThreshold,
  high: 1.5,
  veryHigh: 1.8,
  extremelyHigh: 2.2,
  maximum: 2.5,
};
