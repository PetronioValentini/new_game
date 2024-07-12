import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:new_game/components/game.dart';

void main() {
  
  runApp(
    const GameWidget.controlled(
      gameFactory: MyPhysicsGame.new,
    ),
  );
}
