package roborts;
import robocode.*;

public sealed interface CombatStrategy permits SlowStrategy, FastStrategy {

    public void run();

    public void onScannedRobot();

    public void onHitByBullet();

    public void onHitWall();
}
