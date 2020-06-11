# XReq - eXecutable Requirements - Developer's Guide

## Dependencies
- gnatpro (x86_64)
- gnatpro (arm-eabi)
- gnatcoverage (x86_64)
- gnatcoverage (arm-eabi)
- gnatcheck
- gnatmetric
- gps IDE

## Build
You can run `make help` to see all the available targets.
The variables shown can be overriden with the make syntax:
```
make VAR=VALUE TARGET
```

Typical build is done by running:
```
make clean dev
```

## Source Code edition
To edit the code, open the xreq.gpr file into GPS IDE

## Architecture
### Directories in git repository
Main directories:

- `doc`: Contains the documentation (currently licensing information)
- `examples`: Contains differents examples of use of XReq Tool
- `legacy`: Contains old source code not yet ported/resused in the new architecture
- `scripts`: Contains some helpfull scripts
- `src`: Project source, contains generator, gps plugin and xreq library sources
- `tests`: Source directory for unit and integration tests

Other files:

- `*.gpr`: GPRBuild project files, invoked by `make`, main project is xreq.gpr
- `Makefile`: Build script
- `README.md`: General high level documentation file
- `README_DEV.md`: Developer's Guide
- `COPYING`: Licensing information
- `VERSION`: File containing the current version identification

### Extra directories created at build time

- `build`
- `dist`
- `dist_dev`
- `reports`: Contains reports done at build time such as coverage analysis

### Source code organisation
[TODO]

```
\generator
\gps_plugin
\xreqlib
\xreqlib\arm-eabi
\xreqlib\common
\xreqlib\x86_64
coding_standard
```

Entry point of the generator program: `Main` (`\generator\main.ads`, `\generator\main.adb`)

**`Util` package:**

Contain utilities functions and procedures that are not specific to XReq.

- `Util.IO`: tools to read lines and files in `Unbounded_String`s
- `Util.Strings`: tools to manipulate strings
- `Util.Strings.Pool`: make sure you get a unique string

**`XReq` package:**

- `XReq.CLI`: Help for command line interface
- `XReq.Features`: Feature file parser and abstract syntax tree
- `XReq.Stanzas`: Stanza type, represents a Given, When, Then line in a
  scenario
- `XReq.Steps`: Step definition interface
- `XReq.Steps.Ada`: Step definition and datatypes for the Ada language
- `XReq.Job`: Represents a job, something to do. Generally extracted from
  the command line
- `XReq.Result`: The result of a job, when it is executed. It contains all
  the data to output the test file.


### Data flow

First, the command line create a job (`XReq.Job.Job_Type`) containing the
filename of the feature to execute. To run the job, it must be associated with
and environment (`XReq.Job.Job_Environment`) that contains the output
directory for the tests and the `step_definitions` directory.

The environment is loaded (`XReq.Job.Load`). This step read the
`step_definitions` directory and all the steps in it. The steps
(`XReq.Steps.Steps_Type`) are stored in the environment.

Then, the job is run (`XReq.Job.Run`) and the feature file is parsed
(`XReq.Features.Feature_Type`) and stored in the job. Then, we match each
stanza of each scenario of the feature to steps taken from the environment.

The result (`XReq.Result.Result_Feature_Type`) is the list of scenarios
procedures and all the steps they need to call to run the scenario. Then, the
generator generates Ada code.


### Tests organisation

In the `test` directory there are 2 sub-directories:
- `integ` : contains integration tests, by the use of `features` files
- `unit` : contains unit tests in AUnit format

#### Unit Tests
[TODO]

#### Integration tests
[TODO]

`features` directory

The `features` directory contains many different `.feature` files that describe
features of wspec using the [cucumber](http://cukes.info/) syntax. It also
contains:

- `cucumber`: This contains the cucumber features that do not apply to xreq
  yet. They should be modified to fit xreq in the future.

- `step_definitions`: The step definitions written in Ada that translate the
  sentances in the feature files in code that can be executed

- `tests`: Contains the tests generated by xreq from the feature files. The
  tests generated have the same name as the feature file but with a `.ads` or
  `.adb` suffix.

Additionally, a `data` directory contains features files used as input to test
XReq. They do not test anything, but are used only to stress some features of
XReq.


Tests are generated by the command:
```
make build-feature-tests
```

Tests are run by the command:
```
make run-feature-tests
```

Coverage report is generated into <XREQ_GIT_ROOT>/reports/coverage/feature directory
Simply load the html file into your favorite web browser.

Note that these tests can also be run automatically with the command:
```
make dev
```

### Static code analysis

Some gnat tools can be used for static code analysis like gnatmetric, gnatcheck or gnatprove.

Static analysis can be invoked by the command:
```
make analyze
```

All reports are placed into the report directory.

Note that this target is automatically called with the command:
```
make dev
```

The file <XREQ_GIT_ROOT>/src/coding_standard contains the [rules](http://www.adacore.com/wp-content/files/auto_update/gnat-unw-docs/html/gnat_ugn_24.html)
used.


## Known issues or limitations

### 2011-12-05: Problem parsing step definitions ###

You should define the procedures on the step definition packages in one line.
If you split the procedure on two lines, the procedure name will not be detected
properly.

If you have a body part in your package, the step definition generation will put
the generated procedures in the body part of the package.

### 2010-11-22: Storage_Error in XReqLib ###

Check that the library has been elaborated.


## Strange things

### 2010-04-28: Problem with XReqLib and symbolic traceback ###
[TBC]
It seems that while I use the library with Ada programs only, eerything works
file. But when creating a library for C programs, everything goes wrong. In
particular, the symbolic traceback is not available to dynamic libraries
(missing symbol `gnat__traceback__symbolic__symbolic_traceback__2`).

So, as a workaround, dynamic libraries unfortunately won't use
`GNAT.Traceback.Symbolic.Symbolic_Traceback`. No more advanced debug facilities.


Source Organisation
===================


