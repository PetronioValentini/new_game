import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:new_game/components/level/body_component_with_user_data.dart';

class Ground extends BodyComponentWithUserData {
  final Sprite sprite;

  Ground(Vector2 position, this.sprite)
      : super(
            renderBody: false, // Não renderizar o corpo físico
            bodyDef: BodyDef()
              ..position = position
              ..type = BodyType.static);

  @override
  void onMount() {
    super.onMount();

    final shape = PolygonShape()
      ..setAsBox(
        (sprite.srcSize.x * 1.173) / 2, // Dimensões ajustadas corretamente
        (sprite.srcSize.y * 1.16) / 2,
        Vector2(
          (sprite.srcSize.x * 1.173) /
              2, // Offset para alinhar com o centro do sprite
          -(sprite.srcSize.y * 1.16) /
              2, // Offset y para alinhar ao canto inferior
        ),
        0.0,
      );

    final fixtureDef = FixtureDef(
      shape,
      friction: 0.5,
    );

    // Adiciona o FixtureDef ao corpo
    body.createFixture(fixtureDef);

    // Adiciona o SpriteComponent para renderização
    add(SpriteComponent(
      sprite: sprite,
      size: Vector2(
        sprite.srcSize.x * 1.173,
        sprite.srcSize.y * 1.16,
      ), // 100% CERTO
      anchor: Anchor.bottomLeft,
    ));
  }
}
