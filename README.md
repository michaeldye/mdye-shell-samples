# mdye-shell-samples

[![Status](https://github.com/michaeldye/mdye-shell-samples/actions/workflows/shell-samples.yaml/badge.svg)](https://github.com/michaeldye/mdye-shell-samples/actions)

## Introduction

Shell and GNU / Linux tooling can be nuanced. I built this repository of shell samples to capture these nuances in a form that permits easy review and experimentation. Each script in the [src](./src) dir contains code on a specific topic. Functional tests of each script can be found in [tests](./tests) with names of the form `ftest-<script-name>`.

## Quick Tryout

Install [Docker](https://www.docker.com/), build a local container image and execute tests in the image by invoking:

```
docker build -t localhost/shell-playground .
docker run --rm -it localhost/shell-playground make
```

To clean up created artifacts after execution, see [Cleaning Up](#cleaning-up).

## Playground-Style Use

To experiment and interact with the code in a Docker container that runs tests[^2] on detection of source changes:

1. Build a local Docker image:
   
   ```
   docker build -t localhost/shell-playground .
   ```
   
1. Launch a test container with src mounted from your workstation[^1]:
   
    ```
    docker run --rm --name shell-playground -v $PWD:/shell -it localhost/shell-playground
    ```
    
1. In a separate terminal, edit scripts and their tests locally
1. Watch container output for test failures or lint errors (note that passing tests won't be listed)
1. Optionally, examine workdir content for each script and test (cf. [workdirs](#Workdirs))


To exit the running execute-on-change container, type `CTRL-C`.


### Invoking Individual Tests

It's useful to work on scripts in isolation to experiment with them. Each test script can be invoked directly, for example `./tests/ftest-check-envvars.bash`. When executed this way, stdout and stderr will be printed to the console. For information about the workdirs created when tests are executed, see [workdirs](#Workdirs).

### Envvars

* `DEBUG` - Set envvar `DEBUG=y` to enable trace output in captured `stderr` by the test runner.

## Cleaning Up

To clean up a created Docker image, execute:

```
docker rmi localhost/shell-playground
```

To clean up all state in the local copy of the repository, execute `make clean`. To revert all modified, tracked files in your local copy, execute `make pristine`.

## Workdirs

When invoked by a test or the test runner, each script will be executed in a workdir adjacent to it. For example, when `tests/ftest-truncate.bash` is executed, it runs `src/truncate.bash` in directory `src/truncate.bash.workdir/`. This makes it easy to use the filesystem from a script under test and evaluate the state it consumes or creates.

Note that a separate workdir (this time adjacent to the test executed) is used to capture `stdout` and `stderr` from the script under test when the test runner is invoked, for example by the test runner used by Make in the Docker container or when you invoke `make test` manually. So if `tests/ftest-subshell.bash` is executed this way, `tests/ftest-subshell.bash.workdir/` will be created and populated with the files `stdout` and `stderr`, each capturing output from the script under test at execution time including tracing info if envvar `DEBUG=y` was set.

## Compatibility

All provided scripts and tests are intended to be compatible with modern Linux systems running Bash 4.2 or newer and recent GNU versions of programs `bc`, `column`, `awk`, and `sed`. Note that the Docker image uses recent, stock Ubuntu packages. Github CI uses this mechanism for test and lint execution on each commit. If you run the scripts outside of the Docker container on another platform you may encounter problems.

## Study References

* Updated Bash scripting manual: https://github.com/pmarinov/bash-scripting-guide
* Bash Academy: https://guide.bash.academy/
* HackerRank Linux Shell problems: https://www.hackerrank.com/domains/shell

[^1]: Optionally, pass envvar `DEBUG=y` by modifying the preceding command to include: `docker run ... -e DEBUG=y ...`).
[^2]: The [test runner](util/execute-tests.bash) is really naive about concurrent test execution: the simultaneity isn't controlled, all tests are launched in a subshell as quickly as they can be. Be careful if you expand the samples to include expensive operations or increase their volume considerably.
