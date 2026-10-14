package roborts;
import robocode.*;

public final class VariablePowerStrategy implements CombatStrategy {

    @Override
    public void run(Roborts robot) {
        robot.setColors(robot.white, robot.white, robot.white, robot.white, robot.white);
        while (true) {
            robot.turnGunRight(360);
            robot.turnGunLeft(360);
        }
    }

    @Override
    public void onScannedRobot(Roborts robot) {
        double power = getPower(robot);
        robot.out.println("FIRING! power = " + power + "\n");
        robot.turnGunTo(robot.scannedAngle);
        robot.fire(getPower(robot));
    }

    @Override
    public void onHitByBullet(Roborts robot) {
        int newHeading;
        if (robot.hitByBulletAngle > robot.heading) {
            newHeading = (robot.hitByBulletAngle + 90) % 360;
        } else {
            newHeading = robot.hitByBulletAngle - 90;
            if (newHeading < 360) {
                newHeading += 360;
            }
        }
        robot.turnTo(newHeading);
        robot.ahead(100);
    }

    @Override
    public void onHitWall(Roborts robot) {
        robot.back(20);
    }

    private double getPower(Roborts robot) {
        double speed = Math.abs(robot.scannedVelocity);
        double maxDistance = Math.sqrt(robot.fieldHeight*robot.fieldHeight +
                                        robot.fieldWidth*robot.fieldWidth);
        double relDistance = robot.scannedDistance / maxDistance;

        double power = 3.0 - (3.0 * relDistance);

        power -= speed * 0.125;

        power = Math.min(3.0, power);
        power = Math.max(1.0, power);

        return power;
    }
}
