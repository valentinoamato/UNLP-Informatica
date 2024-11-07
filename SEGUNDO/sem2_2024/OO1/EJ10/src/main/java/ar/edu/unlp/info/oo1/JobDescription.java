package ar.edu.unlp.info.oo1;

public class JobDescription {
    private double effort;
    private int priority;
    private String description;

    public JobDescription (double effort, int priority, String description) {
        this.effort = effort;
        this.priority = priority;
        this.description = description;
    }

    public double getEffort() {
        return this.effort;
    }

    public int getPriority() {
        return this.priority;
    }

    public String getDescription() {
        return this.description;
    }
}
