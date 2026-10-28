package roborts
import robocode.*

internal interface CombatStrategy {

    fun run(robot: Roborts)

    fun onScannedRobot(robot: Roborts)

    fun onHitByBullet(robot: Roborts)

    fun onHitWall(robot: Roborts)
}
