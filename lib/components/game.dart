import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
//import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';
import 'package:new_game/components/level/xml_sprite_sheet.dart';
import 'package:new_game/components/level/ground_manager.dart';

class MyPhysicsGame extends FlameGame {
  MyPhysicsGame()
      : super(
            camera:
                CameraComponent.withFixedResolution(width: 1800, height: 1200));

  late final XmlSpriteSheet tiles;
  late final GroundManager groundManager; // Instância do GroundManager

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
        xmlData:
            await rootBundle.loadString('assets/AltarOfHarmony_tiles.xml'));

    groundManager = GroundManager(tiles);

    await groundManager.addGround(world);
    debugMode = true;

    camera.viewfinder.anchor = Anchor.bottomLeft;
    add(camera);

    return super.onLoad();
  }
}
