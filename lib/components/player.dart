import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';
import 'package:new_game/components/level/ground.dart';


const playerSize = 150.0;
const double jumpForce = 70000000;
const double gravity = 1000000000;
bool isFlip = true;
bool isJumping = false;
bool isOnGround = false;

enum PlayerState { idle }

class Player extends BodyComponent with KeyboardHandler, ContactCallbacks {
  late final SpriteAnimationGroupComponent<PlayerState> animationGroup;
  Vector2 velocity = Vector2.zero();

  Player()
      : super(
          renderBody: false,
          bodyDef: BodyDef()
            ..fixedRotation
            ..position = Vector2(900, -500)
            ..type = BodyType.dynamic,
          fixtureDefs: [
            FixtureDef(
                PolygonShape()..setAsBoxXY(playerSize / 3, playerSize / 2))
              ..restitution = 0.4
              ..density = 0.75
              ..friction = 0.5
              ..isSensor = false
          ],
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animationGroup = SpriteAnimationGroupComponent<PlayerState>(
      animations: {
        PlayerState.idle:
            await loadAnimation('characters/main/rowIdle1.png', 3, 0.15),
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
    final spriteSize = Vector2(146, 204); // Tamanho dos sprites
    final texturePosition = Vector2(2, 11);
    return SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: frameCount,
        stepTime: stepTime,
        textureSize: spriteSize,
        //texturePosition: Vector2(2, 11),
        texturePosition: texturePosition,
      ),
    );
  }

  @override
  void update(double dt) {
    body.setTransform(body.position, 0);
    super.update(dt);
  }

  @override
  onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      controlUp();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      controlLeft();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      controlRight();
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void controlUp() {
    body.applyLinearImpulse(Vector2(0, -jumpForce));
  }

  void controlLeft() {
    body.applyForce(Vector2(-gravity, 0));
    if (!isFlip) {
      animationGroup.flipHorizontallyAroundCenter();
      isFlip = true;
    }
  }

  void controlRight() {
    if (isFlip) {
      animationGroup.flipHorizontallyAroundCenter();
      isFlip = false;
    }
    body.applyForce(Vector2(gravity, 0));
  }

  @override
  void beginContact(Object other, Contact contact) {
    print("aa");
    final fixtureA = contact.fixtureA;
    final fixtureB = contact.fixtureB;

    if ((fixtureA.isSensor || fixtureB.isSensor) && other is Ground) {
      print("contato inicial");
      isOnGround = true;
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    print("aa");
    final fixtureA = contact.fixtureA;
    final fixtureB = contact.fixtureB;

    if ((fixtureA.isSensor || fixtureB.isSensor) && other is Ground) {
      print("contato final");
      isOnGround = false;
    }
  }
}
