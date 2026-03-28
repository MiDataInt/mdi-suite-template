---
published: false
---

## Job log reports

The `logs` folder carries text files containing the output
of the following commands applied to example __TOOL_SUITE_NAME__ job files.

```sh
mdi myJob.yml status # show the state of all submitted jobs
mdi myJob.yml report # show a job log report
mdi myJob.yml ls     # show the contents of a job's output diretory
```

Log file names reflect the pipeline and action they
correspond to, e.g., `<pipeline>_<action>.yml`.

Compare these log reports to your own job logs when
troubleshooting your installation and data analysis.
