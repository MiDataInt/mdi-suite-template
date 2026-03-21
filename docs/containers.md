---
title: Singularity Containers
has_children: false
nav_order: 50
published: true # set to false to remove this tab from your suite's doc site
---

> In 2022, the Apptainer project was released as an open-source fork
> of Singularity, but Apptainer installations still support the `singularity` 
> command. For simplicity and historical reasons, MDI documentation and code  
> mainly use Singularity rather than Apptainer.

## {{page.title}}

Developers can help users enjoy the fastest and most controlled 
pipeline execution by supporting Singularity containers, i.e. Apptainers.
You can choose to wrap your entire tool suite, or just individual pipelines, in 
container images that you distribute in a registry, such as the recommended 
GitHub Container Registry.

- Singularity: <https://sylabs.io/guides/latest/user-guide/>
- Apptainer: <https://apptainer.org/>
- GitHub Container Registry: <https://docs.github.com/en/packages/>

In all cases, the user's system must support Singularity containers. 
If it does not, the MDI CLI will revert to conda-based execution.

### Suite-level containers

The simplest approach is to enable your entire tool suite for container support
by editing files (please see comments within for more information):

- _config.yml
- singularity.def

The advantage of this approach is its simplicity. 
A potential disadvantage is the larger size of the resulting container if
your pipelines require several different conda environments.

An example of the relevant section of _\_config.yml_ activated for suite-level containers is:

```yml
# _config.yml
container:
    supported:  true 
    registry:   ghcr.io 
    owner:      GIT_USER 
    installer:  apt-get
    stages:
        pipelines: true 
        apps:      false # OBSOLETE: no longer used
```

### Pipeline-level containers

Alternatively, you may place individual pipelines into their own containers.
This is accomplished by appropriate edits to:

- pipeline.yml
- pipelines/\<pipeline\>/singularity.def

An example of the relevant section of pipeline.yml activated for pipeline-level containers is:

```yml
# pipeline.yml
container:
    supported: true 
    registry:  ghcr.io 
    owner:     GIT_USER 
    installer: apt-get  
```

Note that suite-level containers take precedence, so set `containers:supported` to false
in _\_config.yml_ if you intend to support pipeline-level containers.

### Container configuration via singularity.def

The operating system and system libraries to be made available in 
your container are specified in _singularity.def_, while program dependencies are 
provided by conda environments pre-installed into the container. In other words,
containers still rely on proper `condaFamilies` declarations - what differs is where
the conda environments are built and by whom.

A complete description of Singularity definition files is beyond scope here
(see link above), but most developers can simply use _singularity.def_
as it is provided in the suite template.  Otherwise, you might think about changing:

```yml
# singularity.def

# declare the operating system
Bootstrap: docker
From: ubuntu:24.04

# add to the %post scriptlet to prepare your container in ways beyond conda
%post
```

### Where code comes from when using versioned containers

Importantly, MDI containers do not carry the final version of all
pipeline code found in a tool suite, e.g., the action scripts.
Those script files are always taken from the most recent code in the 
user's tool suite installation and can reflect a patch version more
recent than the suite version that was used to build a container.

Instead, MDI containers provide the proper program
environment, including built conda environments, that are needed to run
your pipeline scripts. Thus, containers will change much less frequently
than your pipeline actions. Containers only need to change when a program
dependency must be added or updated.

As described in more detail 
[here](https://midataint.github.io/mdi-suite-template/docs/suite_versions.html),
the MDI convention is that any change to the required working environment
of your code is reflected in a change to either the major or minor version,
but that patch version changes never require a new program dependency and
thus do not trigger a new container build. For this reason, MDI container
images are only tagged with major.minor, but not patch versions.

### Building container images via Continuous Integration with GitHub Actions

The conventions above make it easy to support automated container image
building via Continuous Integration (CI) with 
[GitHub Actions](https://github.com/features/actions).

Specifically, the
[MDI Tool Suite Template](https://midataint.github.io/mdi-suite-template/overview)
you should use to create your new tool suite provides templates for 
CI workflows. Copy them as needed from the `templates` to the `.github/workflows`
folder of your tools suite, change just one or two variables, and
the relevant container images will be built and be made available for download by 
end users whenever you push a new major.minor version tag to GitHub. It's that easy!

### Bypassing containers during code development

Notably, container images are most useful for stable distribution code.
You will still likely want and need to build conda environments
manually while developing code and exploring different program environment needs.

In the early development, simply leave the container flags above set to
`supported: false`, which will require the use of locally built conda environments.

Once you have released initial containers, running in developer mode, i.e.,
with the `mdi -d` flag set, will require local conda environments, and/or
you can set the `--runtime conda` option to never use containers.
