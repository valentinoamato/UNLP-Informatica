package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.JobScheduler;
import ar.edu.unlp.info.oo1.JobDescription;

public class MostEffortJobScheduler extends JobScheduler {
    public MostEffortJobScheduler () {
        super();
        this.strategy = "MostEffort";
    }

    public JobDescription next() {
        JobDescription nextJob = this.jobs.stream()
            .max((j1,j2) -> Double.compare(j1.getEffort(), j2.getEffort()))
            .orElse(null);
        this.unschedule(nextJob);
        return nextJob;
    }
}
