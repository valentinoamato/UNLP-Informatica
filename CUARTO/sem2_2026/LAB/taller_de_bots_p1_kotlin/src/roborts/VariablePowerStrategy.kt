package roborts
import robocode.*
import java.awt.Color

// Final por defecto
class VariablePowerStrategy : CombatStrategy {

    override fun run(robot: Roborts) {
        robot.setColors(Color.WHITE.getRGB(), Color.WHITE.getRGB(), Color.WHITE.getRGB(), Color.WHITE.getRGB(), Color.WHITE.getRGB())
        while (true) {
            robot.turnGunRight(360)
            robot.turnGunLeft(360)
        }
    }

    override fun onScannedRobot(robot: Roborts) {
        val power = getPower(robot)
        robot.out.println("FIRING! power = " + power + "\n")
        robot.turnGunTo(robot.scannedAngle)
        robot.fire(getPower(robot))
    }

    override fun onHitByBullet(robot: Roborts) {
        var newHeading: Int
        if (robot.hitByBulletAngle > robot.heading) {
            newHeading = (robot.hitByBulletAngle + 90) % 360
        } else {
            newHeading = robot.hitByBulletAngle - 90
            if (newHeading < 360) {
                newHeading += 360
            }
        }
        robot.turnTo(newHeading)
        robot.ahead(100)
    }

    override fun onHitWall(robot: Roborts) {
        robot.back(20)
    }

    private fun getPower(robot: Roborts): Double {
        val speed = Math.abs(robot.scannedVelocity)
        val maxDistance = Math.sqrt(robot.fieldHeight.toDouble() * robot.fieldHeight +
                                    robot.fieldWidth.toDouble() * robot.fieldWidth)
        val relDistance = robot.scannedDistance / maxDistance

        var power = 3.0 - (3.0 * relDistance)

        power -= speed * 0.125

        power = Math.min(3.0, power)
        power = Math.max(1.0, power)

        return power
    }
}
