import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
//import 'package:new_game/components/level/body_component_with_user_data.dart';

const playerSize = 100.0;

enum PlayerState { idle }

class Player extends BodyComponent {
  late final SpriteAnimationGroupComponent<PlayerState> animationGroup;
  Vector2 velocity = Vector2.zero();
  final double _gravity = 20;
  final double _jumpForce = 700;
  final double _terminalVelocity = 300;

  Player()
      : super(
          //renderBody: true,
          bodyDef: BodyDef()
            ..position = Vector2(900, -500)
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
      anchor: Anchor.center,
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
    //_applyGravity(dt);
    //position.y -= 10;
    //position.x -= 10;
    animationGroup.position;
    animationGroup.angle = body.angle; // Sincroniza o ângulo

    super.update(dt);
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity);
    position.y += velocity.y * dt;
  }
}
