# mdye-shell-samples

[![Status](https://github.com/michaeldye/mdye-shell-samples/actions/workflows/shell-samples.yaml/badge.svg)](https://github.com/michaeldye/mdye-shell-samples/actions)


## Introduction

Shell and GNU / Linux tooling can be nuanced. I built this repository of shell samples to capture these nuances in a form that permits easy review and experimentation. Each script in the [src](./src) dir contains code on a specific topic. Functional tests of each script can be found in [tests](./tests) with names of the form `ftest-<script-name>`.

## Easy Mode Tryout

To skip native installation of dependencies, execute tests in a Docker container with a command like:

```
docker run --rm -it $(docker build -q .) make
```

## Playground-Style Use

### Preconditions and Compatibility

All provided scripts and tests are intended to be compatible with modern Linux systems running Bash 4.2 or newerand the GNU versions of programs `bc`, `column`, `awk`, `sed`. To enable linting functionality, install [shellcheck](https://github.com/koalaman/shellcheck).

### Use
The simplest way to use this repository is to:

1. Make changes to scripts and their tests
1. Execute `make inspect` (or just `make`)
1. Evaluate the test results summary output to determine if a modified test failed (note that passing tests won't be listed)
1. (optionally) Examine workdir content for each script and test (cf. [workdirs](#Workdirs))
1. (optionally) Examine `shellcheck` output for warnings about code in scripts or tests

Note that the [test runner](util/execute-tests.bash) is really naive about concurrent test execution: the simultaneity isn't controlled, all tests are launched in a subshell as quickly as they can be. Be careful if you expand the samples to include expensive operations or increase their volume considerably.

#### Invoking Individual Tests

It's useful to work on scripts in isolation to experiment with them. Each test script can be invoked directly, for example `./tests/ftest-check-envvars.bash`. When executed this way, stdout and stderr will be printed to the console. For information about the workdirs created when tests are executed, see [workdirs](#Workdirs).

### Envvars

* `DEBUG` - Set envvar `DEBUG=y` to enable trace output in captured `stderr` by the test runner.

### Cleaning Up

In order to remove all generated content, execute `make clean`. To revert all modified, tracked files in your local copy, execute: `make pristine`.

## Workdirs

When invoked by a test or the test runner, each script will be executed in a workdir adjacent to it. For example, when `tests/ftest-truncate.bash` is executed, it runs `src/truncate.bash` in directory `src/truncate.bash.workdir/`. This makes it easy to use the filesystem from a script under test and evaluate the state it consumes or creates.

Note that a separate workdir (this time adjacent to the test executed) is used to capture `stdout` and `stderr` from the script under test when the test runner is invoked, for example by executing `make test`. So if `tests/ftest-subshell.bash` is executed by the runner, `tests/ftest-subshell.bash.workdir/` will be created and populated with the files `stdout` and `stderr`, each capturing output from the script under test at execution time.

## Useful

* With [inotifywait](https://man7.org/linux/man-pages/man1/inotifywait.1.html) you can trigger a make target when a file changes on disk:

  ```
  while true; do while inotifywait -e close_write -r .; do make ; done; done
  ```

## References

* Updated Bash scripting manual: https://github.com/pmarinov/bash-scripting-guide
* Bash Academy: https://guide.bash.academy/
* HackerRank Linux Shell problems: https://www.hackerrank.com/domains/shell
