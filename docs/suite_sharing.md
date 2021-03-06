---
title: Suite Sharing
has_children: false
nav_order: 40
published: true # set to false to remove this tab from your suite's doc site
---

## {{page.title}}

All tool suites can be used in either of two patterns we refer to as **suite-centric** and
**mdi-centric**, depending on whether the tool suite or the MDI is the first installation target.
Both patterns ultimately use both the MDI and one or more tool suites.

Importantly, you do not need to do anything specific in this regard - all
MDI tool suites implicitly support both suite-centric and mdi-centric installations.
You might think about adjusting your documentation pages if you prefer one pattern.

### Suite-centric installation

In a suite-centric installation, the user clones and installs a single tool suite.
The _install.sh_ script provided in the suite template clones the MDI and configures
the installation for use. A renamable _run_ script, also provided in the template, executes 
pipelines and launches a web server specific to the tool suite.

In this way, developers and users can think of the tool suite as the primary unit of 
installation and use.

### MDI-centric installation

In an mdi-centric installation, the user instead first clones the MDI installation utility:

- [mdi git repository](https://github.com/MiDataInt/mdi) /
  [documentation](/mdi)

and executes its _install.sh_ script to set up an empty MDI installation. 
You must then make one or more tool suites known to the MDI installation by editing file 
_mdi/config/suites.yml_ as follows:

```yml
# mdi/config/suites.yml
suites:
    - GIT_USER/NAME-mdi-tools # either format works
    - https://github.com/GIT_USER/NAME-mdi-tools.git
```

and repeating the MDI installation.
Alternatively, you can install new suites from within the Stage 2 web server, 
or run the following from the command line:

```bash
mdi add -p -s GIT_USER/NAME-mdi-tools # either format works
mdi add -p -s https://github.com/GIT_USER/NAME-mdi-tools.git
```

In this way, users can maintain an extended MDI installation that carries
many tool suites in a one place, called from a single 'mdi' command target.

### Public vs. private distributions

If your repository is public (recommended), anyone will be able to perform the steps
above to use your tools. 

If your repository is private, you will need to provide a 
[GithHub Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
to clone and use your tool suite. Pass the token to MDI commands by creating file 
_~/gitCredentials.R_ (or, alternatively, _mdi/gitCredentials.R_):

```r
# ~/gitCredentials.R
gitCredentials <- list(
    USER_NAME  = "First Name",
    USER_EMAIL = "namef@umich.edu",
    GIT_USER   = "xxx",
    GITHUB_PAT = "xxx"
)
```

### Add your public tools to the MDI suite registry

For maximum visibility within the MDI, you may list your tool suite
in the registry on the main MDI documentation page. 

Only public suites that offer substantive, purposeful, non-malicious tools 
will be listed in the registry. All code used by your tools must be open source. 
Otherwise, we place no restrictions on the kind of suites you list. 

The steps for listing your suite are:
- fork the docs repo: <https://github.com/MiDataInt/midataint.github.io>
- make a copy of file _/_data/registry/_template.yml_ and edit as needed
- make a pull request to the parent repo

Any developer capable of writing a tool suite should have no problem
executing these steps by following the comments in _ _template.yml_.

When we receive your pull request, we will do a basic level of code review
to ensure that your suite appears appropriate, identifiable, and not nefarious. 
We will then either accept your pull request or reply with needed changes/information.

> **IMPORTANT** - the MDI team never takes responsibility for your code. You are
> responsible for all outcomes and queries related to the use of your tool suite by any user.
