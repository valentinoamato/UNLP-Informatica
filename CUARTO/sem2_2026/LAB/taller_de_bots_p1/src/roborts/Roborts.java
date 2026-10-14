package roborts;
import robocode.*;


public class Roborts extends JuniorRobot
{
    private CombatStrategy combatStrategy = new ElusiveStrategy();

    @Override
    public void run() {
        combatStrategy.run(this);
    }

    @Override
    public void onScannedRobot() {
        combatStrategy.onScannedRobot(this);
    }

    @Override
    public void onHitByBullet() {
        combatStrategy.onHitByBullet(this);
    }

    @Override
    public void onHitWall() {
        combatStrategy.onHitWall(this);
    }
}
