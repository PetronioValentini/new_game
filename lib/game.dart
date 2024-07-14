import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/parallax.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:new_game/components/level/xml_sprite_sheet.dart';
import 'package:new_game/components/level/ground_manager.dart';
import 'package:new_game/components/player.dart';

const height = 1000.0; // 1200 SEM BORDA  1200 COM BORDA
const width = 1292.0; // 1800 SEM BORDA  1600 COM BORDA

class MyPhysicsGame extends Forge2DGame with HasKeyboardHandlerComponents {
  MyPhysicsGame()
      : super(
            gravity: Vector2(0, 1000),
            camera: CameraComponent.withFixedResolution(
                width: width, height: height),
            zoom: 1.3);

  late final XmlSpriteSheet tiles;
  late final GroundManager groundManager;
  late final ParallaxComponent background;
  late final Player player;

  @override
  FutureOr<void> onLoad() async {
    final imagesToLoad = [
      'AltarOfHarmony_03.png',
      'AltarOfHarmony_02.png',
      'AltarOfHarmony_01.png',
    ];

    // Carregar todas as imagens
    final loadedImages = await Future.wait(
      imagesToLoad.map((imageName) => images.load(imageName)),
    );

    background = await ParallaxComponent.load(
        [ParallaxImageData('AltarOfHarmony_background.png')],
        alignment: Alignment.bottomRight, // bottom Right
        repeat: ImageRepeat.noRepeat,
        baseVelocity: Vector2(20, 0),
        velocityMultiplierDelta: Vector2(0, 1.5),
        //size: Vector2(camera.viewport.size.x * 1.5, camera.viewport.size.y));
        size: Vector2(height + 500, width));

    background.position.y -= 250;

    tiles = XmlSpriteSheet(
      imagesMap: Map.fromIterables(imagesToLoad, loadedImages),
      xmlData: await rootBundle.loadString('assets/AltarOfHarmony_tiles.xml'),
    );

    groundManager = GroundManager(tiles);
    await groundManager.addGround(world);

    player = Player();

    world.add(player);

    add(background);

    return super.onLoad();
  }
}
