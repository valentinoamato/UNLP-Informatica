package roborts;
import robocode.*;

public sealed interface CombatStrategy permits VariablePowerStrategy, ElusiveStrategy {

    public void run(Roborts robot);

    public void onScannedRobot(Roborts robot);

    public void onHitByBullet(Roborts robot);

    public void onHitWall(Roborts robot);
}
