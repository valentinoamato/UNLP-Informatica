package roborts;
import robocode.*;


public class Roborts extends JuniorRobot
{

    private interface Strategist {
        public CombatStrategy getRunStrategy(Roborts robot);
        public CombatStrategy getOnScannedRobotStrategy(Roborts robot);
        public CombatStrategy getOnHitByBulletStrategy(Roborts robot);
        public CombatStrategy getOnHitWallStrategy(Roborts robot);
    }

    private final Strategist strategist = DefensiveStrategist.getInstance(this);

    private class AgressiveStrategist implements Strategist {
        private static AgressiveStrategist INSTANCE;
        private CombatStrategy variablePowerSstrategy = new VariablePowerStrategy();
        private CombatStrategy lowEnergyStrategy = new LowEnergyStrategy();

        private AgressiveStrategist() {
        }

        public static Strategist getInstance(Roborts robot) {
            if (INSTANCE == null) {
                INSTANCE = robot.new AgressiveStrategist();
            }
            return INSTANCE;
        }

        @Override
        public CombatStrategy getRunStrategy(Roborts robot) {
            if (robot.energy < 20) {
                return this.lowEnergyStrategy;
            } else {
                return this.variablePowerSstrategy;
            }
        }

        @Override
        public CombatStrategy getOnScannedRobotStrategy(Roborts robot) {
            if (robot.energy < 10) {
                return this.lowEnergyStrategy;
            } else {
                return this.variablePowerSstrategy;
            }
        }

        @Override
        public CombatStrategy getOnHitByBulletStrategy(Roborts robot) {
            return this.variablePowerSstrategy;
        }

        @Override
        public CombatStrategy getOnHitWallStrategy(Roborts robot) {
            return this.lowEnergyStrategy;
        }
    }


    private class DefensiveStrategist implements Strategist {
        private static DefensiveStrategist INSTANCE;
        private CombatStrategy elusiveStrategy = new ElusiveStrategy();
        private CombatStrategy lowEnergyStrategy = new LowEnergyStrategy();

        private DefensiveStrategist() {
        }

        public static Strategist getInstance(Roborts robot) {
            if (INSTANCE == null) {
                INSTANCE = robot.new DefensiveStrategist();
            }
            return INSTANCE;
        }

        @Override
        public CombatStrategy getRunStrategy(Roborts robot) {
            if (robot.energy < 10) {
                return this.lowEnergyStrategy;
            } else {
                return this.elusiveStrategy;
            }
        }

        @Override
        public CombatStrategy getOnScannedRobotStrategy(Roborts robot) {
            if ((robot.energy < 30) || (robot.scannedDistance > 300)) {
                return this.lowEnergyStrategy;
            } else {
                return this.elusiveStrategy;
            }
        }

        @Override
        public CombatStrategy getOnHitByBulletStrategy(Roborts robot) {
            return this.elusiveStrategy;
        }

        @Override
        public CombatStrategy getOnHitWallStrategy(Roborts robot) {
            return this.elusiveStrategy;
        }
    }

    @Override
    public void run() {
        this.setColors(black, black, black, blue, black);
        while (true) {
            strategist.getRunStrategy(this).run(this);
        }
    }

    @Override
    public void onScannedRobot() {
        strategist.getOnScannedRobotStrategy(this).onScannedRobot(this);
    }

    @Override
    public void onHitByBullet() {
        strategist.getOnHitByBulletStrategy(this).onHitByBullet(this);
    }

    @Override
    public void onHitWall() {
        strategist.getOnHitWallStrategy(this).onHitWall(this);
    }
}

