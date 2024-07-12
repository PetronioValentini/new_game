import 'package:flame/components.dart';

class Ground extends SpriteComponent {
  Ground(Vector2 position, Sprite sprite)
      : super(
          sprite: sprite,
          anchor: Anchor.bottomLeft, // bottomLeft centerLeft
          position: position,
        ) {
    // Define o tamanho do componente com base no sprite
    size = Vector2(sprite.srcSize.x.toDouble() * 1.173,
        sprite.srcSize.y.toDouble() * 1.2);
  }
  
}
