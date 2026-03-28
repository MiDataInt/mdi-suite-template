---
published: false
---

## Job file templates

The `templates` folder carries YAML job file templates
you can adapt for running __TOOL_SUITE_NAME__ pipelines on your data.

Template names reflect the pipeline and action they
correspond to, e.g., `<pipeline>_<action>.yml`.

The __TOOL_SUITE_NAME__ CLI can run job files either 
inline in the calling shell or by submitting jobs to your server job scheduler;
the latter is recommended for most use cases. Thus, our most common usage pattern is:

```sh
mdi inspect myJob.yml          # check the formatting of your job file
mdi mkdir myJob.yml            # create any missing output directories
mdi submit --dry-run myJob.yml # test the job file to see what will happen
mdi submit myJob.yml           # submit the job to Slurm or your scheduler
mdi myJob.yml status           # show the state of all submitted jobs
mdi myJob.yml top              # monitor a running job
mdi myJob.yml report           # show a job log report
mdi myJob.yml ls               # show the contents of a job's output diretory
```
