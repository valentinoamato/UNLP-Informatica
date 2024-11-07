package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.JobScheduler;
import ar.edu.unlp.info.oo1.JobDescription;

public class LIFOJobScheduler extends JobScheduler {
    public LIFOJobScheduler () {
        super();
        this.strategy = "LIFO";
    }

    public JobDescription next() {
        JobDescription nextJob = this.jobs.get(this.jobs.size()-1);
        this.unschedule(nextJob);
        return nextJob;
    }
}
