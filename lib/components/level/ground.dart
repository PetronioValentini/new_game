import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:new_game/components/level/body_component_with_user_data.dart';

class Ground extends BodyComponentWithUserData {
  Ground(Vector2 position, Sprite sprite)
      : super(
          renderBody: false,
          bodyDef: BodyDef()
            ..position = position // Definindo a posição
            ..type = BodyType.static,
          fixtureDefs: [
            FixtureDef(
              PolygonShape()
                ..setAsBoxXY(
                  sprite.srcSize.x * 1.173,
                  sprite.srcSize.y * 1.16,
                ),
              friction: 0.3,
            ),
          ],
        ) {
    // Definindo o tamanho do componente
    var size = Vector2(
      sprite.srcSize.x * 1.173,
      sprite.srcSize.y * 1.16,
    );

    // Adicionando o SpriteComponent como filho
    add(SpriteComponent(
      anchor: Anchor.bottomLeft,
      sprite: sprite,
      size: size,
      position: Vector2.zero(),
    ));
  }
}
