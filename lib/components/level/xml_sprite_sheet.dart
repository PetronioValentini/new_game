// ignore_for_file: unused_local_variable

import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:xml/xml.dart';
import 'package:xml/xpath.dart';

class XmlSpriteSheet {
  XmlSpriteSheet({
    required this.imagesMap,
    required String xmlData,
  }) {
    final document = XmlDocument.parse(xmlData);
    for (final node in document.xpath('//TextureAtlas/SubTexture')) {
      final category = node.getAttribute('CATEGORY')!;
      final partName = "${node.getAttribute('PARTNAME')!}.png";
      final texName = "${node.getAttribute('TEX_NAME')!}.png";
      final x = double.parse(node.getAttribute('TEX_X')!);
      final y = double.parse(node.getAttribute('TEX_Y')!);
      final width = double.parse(node.getAttribute('TEX_WIDTH')!);
      final height = double.parse(node.getAttribute('TEX_HEIGHT')!);

      // Associa a imagem correta ao partName
      final image = imagesMap[texName];

      _rects[partName] = Rect.fromLTWH(x, y, width, height);
      _imageMap[partName] = image!;
    }
  }

  final Map<String, ui.Image> imagesMap;
  final _rects = <String, Rect>{};
  final _imageMap = <String, ui.Image>{};

  Sprite getSprite(String name) {
    final rect = _rects[name];
    final image = _imageMap[name];

    return Sprite(
      image!,
      srcPosition: rect!.topLeft.toVector2(),
      srcSize: rect.size.toVector2(),
    );
  }
}
