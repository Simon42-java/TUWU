import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tuwu/components/explosion_component.dart';
import 'package:tuwu/tuwu_game.dart';

class EnemyComponent extends SpriteAnimationComponent
    with HasGameRef<RogueShooterGame>, CollisionCallbacks {
  static const speed = 150;
  static final Vector2 initialSize = Vector2.all(70);

  EnemyComponent({required super.position})
      : super(size: initialSize, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'tuwu/enemy.png',
      SpriteAnimationData.sequenced(
        stepTime: 0.2,
        amount: 8,
        textureSize: Vector2.all(95),
      ),
    );
    add(CircleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    super.update(dt);
    y += speed * dt;
    if (y >= gameRef.size.y) {
      removeFromParent();
    }
  }

  void takeHit() {
    removeFromParent();

    gameRef.add(ExplosionComponent(position: position));
    gameRef.increaseScore();
  }
}