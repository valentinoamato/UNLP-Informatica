package roborts;
import robocode.*;
import roborts.CombatStrategy;
import roborts.FastStrategy;
import roborts.SlowStrategy;



public class Roborts extends JuniorRobot
{
    private CombatStrategy combatStrategy = new SlowStrategy();

    @Override    
    public void run() {
        combatStrategy.run();
    }

    @Override
    public void onScannedRobot() {
        combatStrategy.onScannedRobot();
    }

    @Override
    public void onHitByBullet() {
        combatStrategy.onHitByBullet();
    }

    @Override
    public void onHitWall() {
        combatStrategy.onHitWall();
    }
}
