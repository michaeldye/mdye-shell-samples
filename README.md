# mdye-shell-samples

## Introduction

Shell and GNU / Linux tooling can be nuanced. I built this repository of shell samples to capture these nuances in a form that permits easy review and experimentation. Each script in the [src](./src) dir is a script containing code on a specific topic. Functional tests of each script can be found in [tests](./tests) with names of the form `ftest-<script-name>`.

## Preconditions and Compatibility

Provided scripts and tests are intended to be compatible with modern Linux systems running Bash 4.2 or newer. To enable linting functionality, install [shellcheck](https://github.com/koalaman/shellcheck).

## Functional Testing

The simplest way to use this repository is to:

1. Make changes to scripts and their tests
1. Execute `make inspect` (or just `make`)
1. Evaluate the test results summary to see if tests for each script passed or failed
1. (optionally) Examine workdir content for each script and test (cf. [workdirs](#Workdirs))

### Invoking Individual Tests

It's useful to work on scripts in isolation to experiment with them. Each test script can be invoked directly, for example `./tests/ftest-check-envvars.bash`. When executed this way, stdout and stderr will be printed to the console. For information about the workdirs created when tests are executed, see [workdirs](#Workdirs).

### Cleaning Up

In order to remove all generated content, execute `make clean`. To revert all modified, tracked files in your local copy, execute: `make pristine`.

## Workdirs

When invoked by a test or the test runner, each script will be executed in a workdir adjacent to it. For example, when `tests/ftest-truncate.bash` is executed, it runs `src/truncate.bash` in directory `src/truncate.bash.workdir/`. This makes it easy to use the filesystem from a script under test and evaluate the state it consumes or creates.

Note that a separate workdir (this time adjacent to the test executed) is used to capture `stdout` and `stderr` from the script under test when the test runner is invoked, for example by executing `make test`. So if `tests/ftest-subshell.bash` is executed by the runner, `tests/ftest-subshell.bash.workdir/` will be created and populated with the files `stdout` and `stderr`, each capturing output from the script under test at execution time.
