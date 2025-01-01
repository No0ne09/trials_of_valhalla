import 'package:uuid/uuid.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';

const characterPath = 'game_images/character.png';
const buttonSFXPath = 'assets/audio/sfx/button.wav';
const enemyDeathSfxPath = 'assets/audio/sfx/enemy.wav';
const attackSfxPath = 'assets/audio/sfx/attack.wav';
const jumpSfxPath = 'assets/audio/sfx/jump.wav';
const deathSfxPath = 'assets/audio/sfx/death.wav';
const logoPath = 'assets/images/logo.png';
const jumpButtonPath = 'buttons/jump_button.png';
const attackButtonPath = 'buttons/attack_button.png';
const obstacleWolfPath = "game_images/obstacle_wolf.png";
const enemyBatPath = 'game_images/enemy_bat.png';
const enemyNecroPath = 'game_images/enemy_necro.png';
const enemyDraugrPath = 'game_images/enemy_draugr.png';

const uuid = Uuid();

const baseThreshold = 1.5;
const List<Map<String, double>> thresholdsOptions = [
  {
    minimum: 1.05,
  },
  {
    extremelyLow: 1.1,
  },
  {
    veryLow: 1.25,
  },
  {
    low: 1.4,
  },
  {
    medium: baseThreshold,
  },
  {
    high: 2.0,
  },
  {
    veryHigh: 2.5,
  },
  {
    extremelyHigh: 3.0,
  },
  {
    maxium: 3.5,
  },
];
