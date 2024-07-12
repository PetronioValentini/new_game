import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:new_game/components/level/body_component_with_user_data.dart';
import 'package:new_game/components/level/ground.dart';

const playerSize = 100.0;

enum PlayerState { idle }

class Player extends BodyComponentWithUserData with ContactCallbacks {
  late final SpriteAnimationGroupComponent<PlayerState> animationGroup;

  Player()
      : super(
          //renderBody: true,
          bodyDef: BodyDef()
            ..bullet = true
            ..position = Vector2(500, 300)
            ..type = BodyType.dynamic,
          fixtureDefs: [
            FixtureDef(CircleShape()..radius = playerSize / 2)
              ..restitution = 0.4
              ..density = 0.75
              ..friction = 0.5,
          ],
        );
  
  

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animationGroup = SpriteAnimationGroupComponent<PlayerState>(
      animations: {
        PlayerState.idle:
            await loadAnimation('characters/main/idle.png', 10, 10),
      },
      current: PlayerState.idle,
      size: Vector2.all(playerSize),
      anchor: Anchor.bottomLeft,
    );

    add(animationGroup); // Adicione a animação ao componente
  }

  Future<SpriteAnimation> loadAnimation(
      String imagePath, int frameCount, double stepTime) async {
    final spriteSheet = await game.images.load(imagePath);
    final spriteSize = Vector2(142, 206); // Tamanho dos sprites
    return SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: frameCount,
        stepTime: stepTime,
        textureSize: spriteSize,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    animationGroup.position =
        body.position; // Sincroniza a animação com o corpo
    animationGroup.angle = body.angle; // Sincroniza o ângulo
  }

  @override
  void beginContact(Object other, Contact contact) {
    print('Início do contato');
    if (other is Ground) {
      print('Colidiu com o chão');
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    if (other is Ground) {
      print('Saiu do chão');
    }
  }
}
