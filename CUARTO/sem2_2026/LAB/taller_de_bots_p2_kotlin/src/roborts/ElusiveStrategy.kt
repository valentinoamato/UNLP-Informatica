package roborts
import robocode.*
import java.awt.Color

// Final por defecto
class ElusiveStrategy : CombatStrategy {
    var clockwise = true

    override fun run(robot: Roborts) {
        robot.setColors(Color.BLACK.getRGB(), Color.BLACK.getRGB(), Color.BLACK.getRGB(), Color.BLUE.getRGB(), Color.BLACK.getRGB())
        while (true) {
            if (clockwise) {
                robot.turnGunRight(360)
                robot.turnAheadRight(200, 180)
            } else {
                robot.turnGunLeft(360)
                robot.turnBackRight(200, 180)
            }
        }
    }

    override fun onScannedRobot(robot: Roborts) {
        robot.turnGunTo(robot.scannedAngle)
        robot.fire(2.0)
    }

    override fun onHitByBullet(robot: Roborts) {
        clockwise = !clockwise
    }

    override fun onHitWall(robot: Roborts) {
        if (clockwise) {
            robot.back(50)
        } else {
            robot.ahead(50)
        }
        clockwise = !clockwise
    }
}

