package roborts;
import robocode.*;

public final class LowEnergyStrategy implements CombatStrategy {

    @Override
    public void run(Roborts robot) {
        robot.ahead(100);
        robot.back(100);
    }

    @Override
    public void onScannedRobot(Roborts robot) {
        robot.turnGunTo(robot.scannedAngle);
        robot.fire(0.2);
    }

    @Override
    public void onHitByBullet(Roborts robot) {
        robot.ahead(200);
    }

    @Override
    public void onHitWall(Roborts robot) {
        robot.back(50);
    }
}

