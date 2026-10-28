package roborts
import robocode.*
import java.awt.Color

class LowEnergyStrategy : CombatStrategy {

    override fun run(robot: Roborts) {
        robot.setColors(Color.GREEN.getRGB(), Color.GREEN.getRGB(), Color.WHITE.getRGB(), Color.WHITE.getRGB(), Color.WHITE.getRGB())
        robot.ahead(100)
        robot.back(100)
    }

    override fun onScannedRobot(robot: Roborts) {
        robot.turnGunTo(robot.scannedAngle)
        robot.fire(0.2)
    }

    override fun onHitByBullet(robot: Roborts) {
        robot.ahead(200)
    }

    override fun onHitWall(robot: Roborts) {
        robot.back(50)
    }
}
