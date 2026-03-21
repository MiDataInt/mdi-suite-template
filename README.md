# MDI Tools Suite Template

The [Michigan Data Interface](https://midataint.github.io/) (MDI) 
is a framework for developing, installing and running 
Stage 1 HPC **pipelines** and Stage 2 interactive web applications 
(i.e., **apps**) in a standardized design interface.

This is a **repository template** for creating a new **MDI tools suite**. 
Follow the instructions below to copy this repository, then fill your 
copy with code to define a suite of your own data analysis tools.

The steps below were performed to create a simple demo tool suite
with working pipelines and apps.
- <https://github.com/MiDataInt/demo-mdi-tools.git>

## Template usage

### Create a new repository from this template

**To get started quickly**, 
[click here to create a new suite repository from this template](https://github.com/MiDataInt/mdi-suite-template/generate).

You will be prompted for the user and name of the repository you would like 
to create.

### Copy and use the _template pipeline or app

The easiest way to start a new tool is to copy and modify the _\_template_
pipeline or app, which provides a working boilerplate for all required code. 
Copy/paste the template folder, change its name to match the tool name, and 
start coding and writing documentation files.

### Additional usage instructions

The following documentation pages have detailed information
on the features of your new tool suite and the MDI frameworks
that will help you quickly develop pipelines and apps:

- [Tool suite template documentation](https://midataint.github.io/mdi-suite-template)
- [MDI pipelines framework documentation](https://midataint.github.io/mdi-pipelines-framework)
- [MDI apps framework documentation](https://midataint.github.io/mdi-apps-framework)

### Finishing your main tool suite README.md

This file will become the README for your tool suite to edit as needed.
Delete everything up to this section, then modify the sections below 
to match your tool suite. 

Most tool suites are recommended to use a single-suite intallation.
If a multi-suite installation is better for your application, or not 
recommended at all, move and/or delete the different installation 
sections as needed.

# __TOOL_SUITE_NAME__ Tool Suite

**__TOOL_SUITE_NAME__** carries pipelines and apps for
DOING SOMETHING INTERESTING.

The steps to using __TOOL_SUITE_NAME__ are to:
- install the codebase in this repository
- build the conda environment (if not using Singularity/Apptainer)
- MORE STEPS HERE
- visualize results in the R Shiny apps

## Single-suite installation (recommended)

__TOOL_SUITE_NAME__ is implemented in the
[Michigan Data Interface](https://midataint.github.io/) (MDI)
for developing, installing and running Stage 1 HPC **pipelines** 
and Stage 2 interactive web **apps**. For __TOOL_SUITE_NAME__, 
we recommend a single-suite installation, which is accomplished by:
- cloning this tool suite repository
- running _install.sh_
- optionally running _alias.pl_ to create an `__TOOL_SUITE_SHORT_NAME__` alias to the command line interface (CLI)

### Install this tool suite

```bash
git clone https://github.com/__GIT_OWNER__/__TOOL_SUITE_NAME__.git
cd __TOOL_SUITE_NAME__
./install.sh
```

To start, answer 'y' (yes) to install the Stage 1 Pipelines, then after a
minute, answer 'n' (no) to skip installation of the Stage 2 Apps (for now).

### Create an alias to the suite's command line interface (optional)

```bash
# you can use a different alias if you'd like, e.g., replace __TOOL_SUITE_SHORT_NAME__ with __TOOL_SUITE_NAME__
perl alias.pl __TOOL_SUITE_SHORT_NAME__ 
```

Answer 'y' to add the alias to your bash profile, then 
reload a new shell to activate the alias for use.

If you prefer not to use an alias, 
add the installation directory to your PATH variable
or `cd` into the directory prior to calling `./__TOOL_SUITE_SHORT_NAME__`.

### Test the command line interface (CLI)

For help, call the CLI with no arguments, which describes the format for pipeline calls. 

```bash
# use the alias, if you created it as described above
__TOOL_SUITE_SHORT_NAME__ 
__TOOL_SUITE_SHORT_NAME__ --help

# or call the CLI directly without an alias
cd __TOOL_SUITE_NAME__
./__TOOL_SUITE_SHORT_NAME__
./__TOOL_SUITE_SHORT_NAME__ --help
```

## Build the required Conda environment

__TOOL_SUITE_NAME__ pipelines use version-controlled 3rd-party software built into a 
[conda](https://docs.conda.io/)
environment. Build that environment in your __TOOL_SUITE_NAME__ installation as follows:

```sh
__TOOL_SUITE_SHORT_NAME__ analyze conda --create
```

You must have `conda` available in your environment. If you need to run
a command to make conda available, follow the instructions in
`.../mdi/config/stage1-pipelines.yml`, which is pre-configured to work on
the University of Michigan Great Lakes cluster.

In a shared server environment, the conda build command may get killed by the host.
If that happens, run the command on a cluster worker node with sufficient resources,
e.g., 4 CPU with 4G RAM per CPU works well.

```sh
# example for a Slurm-based cluster server
salloc --account <your_slurm_account> --cpus-per-task 4 --mem-per-cpu 4G 
__TOOL_SUITE_SHORT_NAME__ analyze conda --create
exit
```

## Execute a pipeline from the command line

### Job files

__TOOL_SUITE_NAME__ pipelines can be called entirely using the CLI introduced above. However, you 
are encouraged to create YAML-format job configuration files that define the
parameters for your job and execution steps.

See [the templates folder](https://github.com/__GIT_OWNER__/__TOOL_SUITE_NAME__/tree/main/templates)
for job file templates for all __TOOL_SUITE_NAME__ pipelines
and actions, and <https://midataint.github.io/mdi/docs/job_config_files.html>
for extended help on using job files. Job file templates can also be generated with 
command `__TOOL_SUITE_SHORT_NAME__ <pipeline> template`, e.g., `__TOOL_SUITE_SHORT_NAME__ basecall template`.

The __TOOL_SUITE_NAME__ CLI and job files can run pipeline actions either 
inline in the calling shell or by submitting jobs to your server job scheduler.
The latter is recommended for most use cases. Thus, our most common usage pattern is:

```sh
__TOOL_SUITE_SHORT_NAME__ inspect myJob.yml          # check the formatting of your job file
__TOOL_SUITE_SHORT_NAME__ mkdir myJob.yml            # create any missing output directories
__TOOL_SUITE_SHORT_NAME__ submit --dry-run myJob.yml # test the job file to see what will happen
__TOOL_SUITE_SHORT_NAME__ submit myJob.yml           # submit the job to Slurm or your scheduler
__TOOL_SUITE_SHORT_NAME__ myJob.yml status           # show the state of all submitted jobs
__TOOL_SUITE_SHORT_NAME__ myJob.yml top              # monitor a running job
__TOOL_SUITE_SHORT_NAME__ myJob.yml report           # show a job log report
__TOOL_SUITE_SHORT_NAME__ myJob.yml ls               # show the contents of a job's output diretory
```

### Workflow sequence

__TOOL_SUITE_NAME__ has _pipelines_ each with associated _actions_ with descriptive names, 
listed here in execution order of the most common actions:
- `__PIPELINE__ __ACTION__` (where `__PIPELINE__` is a _pipeline_ and `__ACTION__` is an _action_)

Required/common options are described below; use 
`__TOOL_SUITE_SHORT_NAME__ <pipeline> <action> --help` or `__TOOL_SUITE_SHORT_NAME__ <pipeline> template` 
for complete option information, or see the output of all action help commands
[here](https://github.com/__GIT_OWNER__/__TOOL_SUITE_NAME__/tree/main/options).

### Universally required options

Options `--output-dir/-O` and `--data-name/-N` are required by all pipeline actions.
Output files are placed into directory `<--output-dir>/<--data-name>`.

## Required input files

COMPLETE THIS SECTION.

## Recommended __TOOL_SUITE_NAME__ workspace organization

The following is an optional but time-tested strategy for organizing input,
output, job, and resource files in your __TOOL_SUITE_NAME__ workspace 
(create *** folders manually as needed).

```sh
__TOOL_SUITE_NAME__                    # root folder you created above
├── input                  # *** folder for your input data files
│   └── project1           # *** subfolder for a related set of samples
├── jobFiles               # *** folder for your job configuration files
│   └── project1
├── mdi                    # MDI codebase folder created by __TOOL_SUITE_NAME__ installation
│   ├── config             # folder with configuration files you may need
│   └── resources          # folder where resource files are placed by default
└── output                 # *** folder for your output data files
    └── project1
```

## ADDITIONAL DESCRIPITION SECTIONS

COMPLETE AS NEEDED.

## Launch the interactive apps server

Once all pipelines have finished running, you will want to view and interact
with your data.

To install and launch the __TOOL_SUITE_NAME__ apps server, we recommend using the 
[MDI Desktop app](https://midataint.github.io/mdi-desktop-app),
which allows you to control both local and remote MDI web servers.

After following the instructions to run the Desktop on your local machine
or server, load a __TOOL_SUITE_NAME__ data package file ending in `.mdi.package.zip`,
into the app interface.

## Alternative multi-suite installation

You can alternatively install __TOOL_SUITE_NAME__ as part of an MDI 
**multi-suite installation** that carries multiple distinct tool suites.

In the multi-suite mode, you will:
- clone and install the MDI framework
- add __TOOL_SUITE_NAME__ (and later others) to your MDI installation
- call the `mdi` utility to use tools from any installed suite

### Install the MDI framework

```bash
git clone https://github.com/MiDataInt/mdi.git
cd mdi
./install.sh
```

To start, answer 'y' (yes) to install the Stage 1 Pipelines, then after a
minute, answer 'n' (no) to skip installation of the Stage 2 Apps (for now).

### Add an mdi alias to .bashrc (optional)

```bash
./mdi alias --help
./mdi alias --alias mdi # change the alias name if you'd like 
mdi
```

Answer 'y' to add the alias to your bash profile, then 
reload a new shell to activate the alias for use.

If you prefer not to use an alias, 
add the MDI installation directory to your PATH variable,
or `cd` into the directory prior to calling `./mdi`.

### Add __TOOL_SUITE_NAME__ to your MDI installation

```bash
./mdi add --help
./mdi add --suite __GIT_OWNER__/__TOOL_SUITE_NAME__
```

Later you can add as many additional tool suites
to this same MDI installation as needed, which can reduce
disk utilization for resource files and R libraries.
