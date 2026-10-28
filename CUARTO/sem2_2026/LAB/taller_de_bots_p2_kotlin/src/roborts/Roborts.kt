package roborts
import robocode.*


// Publica por defecto
class Roborts : JuniorRobot() {

    private interface Strategist {
        fun getRunStrategy(robot: Roborts): CombatStrategy
        fun getOnScannedRobotStrategy(robot: Roborts): CombatStrategy
        fun getOnHitByBulletStrategy(robot: Roborts): CombatStrategy
        fun getOnHitWallStrategy(robot: Roborts): CombatStrategy
    }

    private val strategist: Strategist = DefensiveStrategist()

    private class AgressiveStrategist : Strategist {

        private val variablePowerStrategy: CombatStrategy = VariablePowerStrategy()
        private val lowEnergyStrategy: CombatStrategy = LowEnergyStrategy()

        override fun getRunStrategy(robot: Roborts): CombatStrategy {
            return if (robot.energy < 20) {
                lowEnergyStrategy
            } else {
                variablePowerStrategy
            }
        }

        override fun getOnScannedRobotStrategy(robot: Roborts): CombatStrategy {
            return if (robot.energy < 10) {
                lowEnergyStrategy
            } else {
                variablePowerStrategy
            }
        }

        override fun getOnHitByBulletStrategy(robot: Roborts): CombatStrategy {
            return variablePowerStrategy
        }

        override fun getOnHitWallStrategy(robot: Roborts): CombatStrategy {
            return lowEnergyStrategy
        }
    }

    private class DefensiveStrategist : Strategist {

        private val elusiveStrategy: CombatStrategy = ElusiveStrategy()
        private val lowEnergyStrategy: CombatStrategy = LowEnergyStrategy()

        override fun getRunStrategy(robot: Roborts): CombatStrategy {
            return if (robot.energy < 10) {
                lowEnergyStrategy
            } else {
                elusiveStrategy
            }
        }

        override fun getOnScannedRobotStrategy(robot: Roborts): CombatStrategy {
            return if (robot.energy < 30 || robot.scannedDistance > 300) {
                lowEnergyStrategy
            } else {
                elusiveStrategy
            }
        }

        override fun getOnHitByBulletStrategy(robot: Roborts): CombatStrategy {
            return elusiveStrategy
        }

        override fun getOnHitWallStrategy(robot: Roborts): CombatStrategy {
            return elusiveStrategy
        }
    }

    override fun run() {
        while (true) {
            strategist.getRunStrategy(this).run(this)
        }
    }

    override fun onScannedRobot() {
        strategist.getOnScannedRobotStrategy(this).onScannedRobot(this)
    }

    override fun onHitByBullet() {
        strategist.getOnHitByBulletStrategy(this).onHitByBullet(this)
    }

    override fun onHitWall() {
        strategist.getOnHitWallStrategy(this).onHitWall(this)
    }
}
