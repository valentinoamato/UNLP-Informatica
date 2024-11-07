package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.JobScheduler;
import ar.edu.unlp.info.oo1.JobDescription;

public class FIFOJobScheduler extends JobScheduler {
    public FIFOJobScheduler () {
        super();
        this.strategy = "FIFO";
    }

    public JobDescription next() {
        JobDescription nextJob = this.jobs.get(0);
        this.unschedule(nextJob);
        return nextJob;
    }
}
