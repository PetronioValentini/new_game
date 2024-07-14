import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_game/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen(); 
  await Flame.device.setLandscape(); 
  MyPhysicsGame game = MyPhysicsGame();
  runApp(GameWidget(game: kDebugMode ? MyPhysicsGame() : game));
}
