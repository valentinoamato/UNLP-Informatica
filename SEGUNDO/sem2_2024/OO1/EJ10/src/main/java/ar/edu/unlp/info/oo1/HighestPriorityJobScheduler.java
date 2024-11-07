package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.JobScheduler;
import ar.edu.unlp.info.oo1.JobDescription;

public class HighestPriorityJobScheduler extends JobScheduler {
    public HighestPriorityJobScheduler () {
        super();
        this.strategy = "HighestPriority";
    }

    public JobDescription next() {
        JobDescription nextJob = this.jobs.stream()
            .max((j1,j2) -> Double.compare(j1.getPriority(), j2.getPriority()))
            .orElse(null);
        this.unschedule(nextJob);
        return nextJob;
    }
}
