import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';
import 'package:new_game/components/level/xml_sprite_sheet.dart';
import 'package:new_game/components/level/ground_manager.dart';
import 'package:new_game/components/player.dart';

class MyPhysicsGame extends Forge2DGame with HasKeyboardHandlerComponents {
  MyPhysicsGame()
      : super(
            gravity: Vector2(0, 1000),
            camera:
                CameraComponent.withFixedResolution(width: 1800, height: 1200),
            zoom: 1.0);

  late final XmlSpriteSheet tiles;
  late final GroundManager groundManager;

  @override
  Future<void> onLoad() async {
    final imagesToLoad = [
      'AltarOfHarmony_03.png',
      'AltarOfHarmony_02.png',
      'AltarOfHarmony_01.png',
    ];

    // Carregar todas as imagens
    final loadedImages = await Future.wait(
      imagesToLoad.map((imageName) => images.load(imageName)),
    );

    tiles = XmlSpriteSheet(
      imagesMap: Map.fromIterables(imagesToLoad, loadedImages),
      xmlData: await rootBundle.loadString('assets/AltarOfHarmony_tiles.xml'),
    );

    groundManager = GroundManager(tiles);
    await groundManager.addGround(world);

    //await groundManager.addGround(world);

    Player player = Player();

    //await world.add(player);
    world.add(player);

    camera.viewfinder.anchor = Anchor.bottomLeft; // sempre por ultimo

    //debugMode = true;

    return super.onLoad();
  }
}
