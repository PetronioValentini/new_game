import 'package:flame/components.dart';
import 'package:new_game/components/level/ground.dart';
import 'package:new_game/components/level/xml_sprite_sheet.dart';

class GroundManager {
  final XmlSpriteSheet tiles;

  GroundManager(this.tiles);

  Future<void> addGround(World world) async {
    List<Map<String, dynamic>> groundConfig = [
      {
        'partName': 'AltarOfHarmony_Fl_A.png',
        'position': Vector2(0, 0),
      },
      {
        'partName': 'AltarOfHarmony_Fl_B.png',
        'position': Vector2(600, 0),
      },
      {
        'partName': 'AltarOfHarmony_Fl_A.png',
        'position': Vector2(1200, 0),
      },
      {
        'partName': 'AltarOfHarmony_0050_2/2.png',
        'position': Vector2(421, -135),
      },
      {
        'partName': 'AltarOfHarmony_0040_3/3.png',
        'position': Vector2(431, -376),
      },
      {
        'partName': 'AltarOfHarmony_0050_1/2.png',
        'position': Vector2(1309, -642),
      },
      {
        'partName': 'AltarOfHarmony_0035_1/2.png',
        'position': Vector2(1123, -153),
      },
      {
        'partName': 'AltarOfHarmony_0035_1/2.png',
        'position': Vector2(1228, -473),
      },
      {
        'partName': 'AltarOfHarmony_0050_1/2.png',
        'position': Vector2(1201, -322),
      },
      {
        'partName': 'AltarOfHarmony_0035_1/2.png',
        'position': Vector2(-42, -234),
      },
      {
        'partName': 'AltarOfHarmony_0025_B.png',
        'position': Vector2(-177, -497),
      },
      //
      {
        'partName': 'AltarOfHarmony_0050_1/2.png',
        'position': Vector2(-179, -123),
      },
      {
        'partName': 'AltarOfHarmony_0035_2/2.png',
        'position': Vector2(450, -254),
      },
      {
        'partName': 'AltarOfHarmony_0040_2/3.png',
        'position': Vector2(-169, -375),
      },
      {
        'partName': 'AltarOfHarmony_0035_2/2.png',
        'position': Vector2(1615, -173),
      },
      {
        'partName': 'AltarOfHarmony_0035_2/2.png',
        'position': Vector2(1720, -493),
      },
    ];
    for (var config in groundConfig) {
      final Sprite sprite = tiles.getSprite(config['partName']);
      await world.add(
          Ground(Vector2(config['position'].x, config['position'].y), sprite));
    }
  }
}