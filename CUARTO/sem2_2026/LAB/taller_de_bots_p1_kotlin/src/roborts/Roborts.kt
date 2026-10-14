package roborts
import robocode.*


// Publica por defecto
class Roborts : JuniorRobot() {

    // val -> solo lectura
    private val combatStrategy: CombatStrategy = VariablePowerStrategy()

    // Publico por defecto
    override fun run() {
        combatStrategy.run(this)
    }

    override fun onScannedRobot() {
        combatStrategy.onScannedRobot(this)
    }

    override fun onHitByBullet() {
        combatStrategy.onHitByBullet(this)
    }

    override fun onHitWall() {
        combatStrategy.onHitWall(this)
    }
}
