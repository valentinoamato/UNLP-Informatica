package roborts;
import robocode.*;

public final class ElusiveStrategy implements CombatStrategy {
    boolean clockwise = true;

    @Override
    public void run(Roborts robot) {
        robot.setColors(robot.black, robot.black, robot.black, robot.blue, robot.black);
        while (true) {
            if (clockwise) {
                robot.turnGunRight(360);
                robot.turnAheadRight(200, 180);
            } else {
                robot.turnGunLeft(360);
                robot.turnBackRight(200, 180);
            }
        }
    }

    @Override
    public void onScannedRobot(Roborts robot) {
        robot.turnGunTo(robot.scannedAngle);
        robot.fire(2.0);
    }

    @Override
    public void onHitByBullet(Roborts robot) {
        clockwise = !clockwise;
    }

    @Override
    public void onHitWall(Roborts robot) {
        if (clockwise) {
            robot.back(50);
        } else {
            robot.ahead(50);
        }
        clockwise = !clockwise;
    }
}

