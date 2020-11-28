Startup time of different programming languages
===============================================

The startup time of a programming language is important for short running programs that are called
interactively by the user or are called (many times) by other programs. For example, the version
control system Git is written in C and the invoked commands (like `git status` and `git log`)
execute fast. The version control systems Bazaar and Mercurial are written in Python. They take
much longer to execute than Git and they feel slow compared to Git. The startup time of Python
contributes an important portion of the execution time.

Several years ago, I wrote a small script named `distro-info` which provides information about the
Debian/Ubuntu releases. This script is called in a bash completion for pbuilder-dist (from the
ubuntu-dev-tools package). An Ubuntu user experience a
[bash startup of 4 seconds](https://launchpad.net/bugs/796317) with cold cache due to the multiple
invocations of `distro-info`. This made me search a suitable programming language with a fast
startup time and I wrote this project to measure the startup time of many programming languages.

This project consists of many hello world programs in different languages and an ugly Makefile that
compiles the programs and runs the benchmark. Each program is run 1000 times in a row (using a tiny
`run.c` program to minimize the overhead for the invocation):

```sh
time -f "%e" taskset -c 0 ./run 1000 $program
```

Usage
=====

Before running the benchmark, install all relevant compilers. On Debian/Ubuntu you can run
`make install` to install the compilers. Then start the benchmark by calling `make`.

There are some optional interpreters/compilers present in this project that are
not present in Debian or Ubuntu (~2020) that will be included only if the
compilers or interpreters are present on your system. These include:

* Crystal
* Crystal (compiled with the MUSL C library to support static binary compilation)
* Ruby 1.8 -- an old version with an older interpreter architecture that had a
  faster startup time.
* QuickJS -- a lightweight, embeddable JS interpreter

Here is output from 2020 on an Intel Core i7-5600U @2.60 GHz processor on a laptop:
```
$ make
Run on: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz | Debian GNU/Linux 10 (buster) | 2020-11-27
C (gcc 8.3.0):                                          0.25 ms
C_MUSL (musl-gcc 8.3.0 / musl 1.1.21):                  0.05 ms
C++ (g++ 8.3.0):                                        0.73 ms
Cython (cython 0.29.2):                                 8.34 ms
Cython3 (cython3 0.29.2):                               11.37 ms
D (gdc 8.3.0):                                          2.46 ms
Dart (dart2native 2.10.4):                              3.92 ms
Go (go go1.11.6):                                       0.63 ms
Go_GCC (gccgo 8.3.0):                                   11.36 ms
Haskell (ghc 8.4.4):                                    0.71 ms
OCaml (ocamlc 4.05.0):                                  0.95 ms
Pascal (fpc 3.0.4):                                     0.07 ms
Rust (rustc 1.41.1):                                    0.47 ms
Crystal (crystal 0.35.1):                               1.28 ms
Crystal_MUSL (crystal_musl 0.35.1 / musl 1.1.21):       0.39 ms
Awk (GNU Awk 4.2.1):                                    0.97 ms
Bash 5.0.3(1):                                          0.65 ms
CShell 20110502-4+deb10u1:                              1.79 ms
DuktapeJS (duktape js 2.3.0):                           1.04 ms
Lua 5.3.3:                                              0.60 ms
MRuby 2.0.0:                                            2.05 ms
NodeJS v10.21.0:                                        445.47 ms
Perl 5.28.1:                                            0.90 ms
PHP 7.3.19:                                             9.64 ms
Python-S 2.7.16:                                        2.78 ms
Python 2.7.16:                                          7.99 ms
Python3-S 3.7.3:                                        7.23 ms
Python3 3.7.3:                                          10.66 ms
PyPy 7.0.0:                                             24.72 ms
Ruby 2.5.5p157:                                         46.39 ms
Shell (dash 0.5.10.2):                                  0.30 ms
ZShell 5.7.1:                                           1.27 ms
QJS (quickjs 2020-11-08):                               0.74 ms
Ruby18 1.8.7:                                           1.57 ms
C# (mcs 5.18.0.240):                                    14.22 ms
Java (javac 11.0.8):                                    54.67 ms
Scala (scalac 2.11.12):                                 766.54 ms
```

Here is older output from the original author of this project:
```
$ make
Run on: Intel(R) Core(TM) i5-2400S CPU @ 2.50GHz | Ubuntu 17.10 | 2018-02-10
C (gcc 7.2.0):            0.26 ms
C++ (g++ 7.2.0):          0.79 ms
Cython (cython 0.25.2):   9.91 ms
Cython3 (cython3 0.25.2): 26.04 ms
D (gdc 7.2.0):            0.57 ms
Go (go go1.8.3):          0.41 ms
Go_GCC (gccgo 7.2.0):     98.26 ms
Haskell (ghc 8.0.2):      0.72 ms
Pascal (fpc 3.0.2):       0.08 ms
Rust (rustc 1.21.0):      0.51 ms
Bash 4.4.12(1):           0.71 ms
CShell 20110502:          3.26 ms
Lua 5.2.4:                0.63 ms
Perl 5.26.0:              0.94 ms
PHP 7.1.11:               8.71 ms
Python-S 2.7.14:          2.91 ms
Python 2.7.14:            9.43 ms
Python3-S 3.6.3:          9.31 ms
Python3 3.6.3:            25.84 ms
PyPy 5.8.0:               27.53 ms
Ruby 2.3.3p222:           32.43 ms
Shell (dash 0.5.8):       0.33 ms
ZShell 5.2:               1.57 ms
C# (mcs 4.6.2.0):         13.37 ms
Java (javac 1.8.0_151):   54.55 ms
Scala (scalac 2.11.8):    310.81 ms
```

```
$ make
Run on: Raspberry Pi 3 (arm64) | Debian GNU/Linux buster/sid | 2018-02-10
C (gcc 7.2.0):            2.19 ms
C++ (g++ 7.2.0):          8.24 ms
Cython (cython 0.26.1):   98.71 ms
Cython3 (cython3 0.26.1): 196.36 ms
Go (go go1.9.3):          4.10 ms
Go_GCC (gccgo 7.2.0):     898.30 ms
Haskell (ghc 8.0.2):      9.44 ms
Pascal (fpc 3.0.4):       0.66 ms
Rust (rustc 1.22.1):      4.42 ms
Bash 4.4.12(1):           7.31 ms
CShell 20110502:          10.98 ms
Lua 5.2.4:                6.23 ms
Perl 5.26.1:              8.78 ms
PHP 7.2.2:                98.03 ms
Python-S 2.7.14+:         32.77 ms
Python 2.7.14+:           91.85 ms
Python3-S 3.6.4:          110.02 ms
Python3 3.6.4:            197.79 ms
PyPy 5.8.0:               183.50 ms
Ruby 2.3.6p384:           421.53 ms
Shell (dash 0.5.8):       2.81 ms
ZShell 5.4.2:             11.04 ms
C# (mcs 4.6.2.0):         137.53 ms
Java (javac 1.8.0_151):   566.66 ms
Scala (scalac 2.11.8):    2989.72 ms
```

If you don't want to test all programming languages, edit `COMPILED_LANGS` and `INTERPRETED_LANGS`
in `Makefile` (and maybe edit the `all` target to not depend on the .exe and .class files).
Note: The Makefile should be replaced by something else that is simpler to read and can produce
nicer looking output.

Newer Results
=============

| Language                    | Version        |  Intel Core i7-5600U |
|:----------------------------|:---------------|---------------------:|
| C-MUSL (musl-gcc)           | 1.1.21         |              0.05 ms |
| Pascal (fpc)                | 3.0.4          |              0.07 ms |
| C (gcc)                     | 8.3.0          |              0.25 ms |
| Shell (dash)                | 0.5.10.2       |              0.30 ms |
| Crystal-MUSL (crystal-musl) | 1.1.21         |              0.39 ms |
| Rust (rustc)                | 1.41.1         |              0.47 ms |
| Lua                         | 5.3.3          |              0.60 ms |
| Go (go)                     | 1.11.6         |              0.63 ms |
| Bash                        | 5.0.3          |              0.65 ms |
| Haskell (ghc)               | 8.4.4          |              0.71 ms |
| C++ (g++)                   | 8.3.0          |              0.73 ms |
| QJS (quickjs)               | 2020-11-08     |              0.74 ms |
| Perl                        | 5.28.1         |              0.90 ms |
| OCaml (ocamlc)              | 4.05.0         |              0.95 ms |
| Awk (GNU)                   | 4.2.1          |              0.97 ms |
| DuktapeJS (duktape)         | 2.3.0          |              1.04 ms |
| ZShell                      | 5.7.1          |              1.27 ms |
| Crystal (crystal)           | 0.35.1         |              1.28 ms |
| Ruby18                      | 1.8.7          |              1.57 ms |
| CShell                      | 20110502-4     |              1.79 ms |
| MRuby                       | 2.0.0          |              2.05 ms |
| D (gdc)                     | 8.3.0          |              2.46 ms |
| Python-S                    | 2.7.16         |              2.78 ms |
| Dart (dart2native)          | 2.10.4         |              3.95 ms |
| Python3-S                   | 3.7.3          |              7.23 ms |
| Python                      | 2.7.16         |              7.99 ms |
| Cython (cython)             | 0.29.2         |              8.34 ms |
| PHP                         | 7.3.19         |              9.64 ms |
| Python3                     | 3.7.3          |             10.66 ms |
| Go-GCC (gccgo)              | 8.3.0          |             11.36 ms |
| Cython3 (cython3)           | 0.29.2         |             11.37 ms |
| C# (mcs)                    | 5.18.0.240     |             14.22 ms |
| PyPy                        | 7.0.0          |             24.72 ms |
| Ruby                        | 2.5.5p157      |             46.39 ms |
| Java (javac)                | 11.0.8         |             54.67 ms |
| NodeJS                      | 10.21.0        |            445.47 ms |
| Scala (scalac)              | 2.11.12        |            766.54 ms |

Older Results
=============

| Language          | version               | Intel Core i5 2400S | Raspberry Pi 3 |
| ------------------|---------------------- | ------------------: | -------------: |
| Pascal (fpc)      | 3.0.2 / 3.0.4         |             0.08 ms |        0.66 ms |
| C (gcc)           | 7.2.0                 |             0.26 ms |        2.19 ms |
| Shell (dash)      | 0.5.8                 |             0.33 ms |        2.81 ms |
| Go (go)           | 1.8.3 / 1.9.3         |             0.41 ms |        4.10 ms |
| Rust (rustc)      | 1.21.0 / 1.22.1       |             0.51 ms |        4.42 ms |
| D (gdc)           | 7.2.0                 |             0.57 ms |                |
| Lua               | 5.2.4                 |             0.63 ms |        6.23 ms |
| Bash              | 4.4.12(1)             |             0.71 ms |        7.31 ms |
| C++ (g++)         | 7.2.0                 |             0.79 ms |        8.24 ms |
| Perl              | 5.26.0 / 5.26.1       |             0.94 ms |        8.78 ms |
| Haskell (ghc)     | 8.0.2                 |             0.72 ms |        9.44 ms |
| ZShell            | 5.2 / 5.4.2           |             1.57 ms |       11.04 ms |
| CShell            | 20110502              |             3.26 ms |       10.98 ms |
| Python (with -S)  | 2.7.14                |             2.91 ms |       32.77 ms |
| Python            | 2.7.14                |             9.43 ms |       91.85 ms |
| PHP               |  7.1.11 / 7.2.2       |             8.71 ms |       98.03 ms |
| Cython            | 0.25.2 / 0.26.1       |             9.91 ms |       98.71 ms |
| Python3 (with -S) | 3.6.3 / 3.6.4         |             9.31 ms |      110.02 ms |
| C# (mcs)          | 4.6.2.0               |            13.37 ms |      137.53 ms |
| PyPy              | 5.8.0                 |            27.53 ms |      183.50 ms |
| Cython3           | 0.25.2 / 0.26.1       |            26.04 ms |      196.36 ms |
| Python3           | 3.6.3 / 3.6.4         |            25.84 ms |      197.79 ms |
| Ruby              | 2.3.3p222 / 2.3.6p384 |            32.43 ms |      421.53 ms |
| Java (javac)      | 1.8.0_151             |            54.55 ms |      566.66 ms |
| Go (gccgo)        | 7.2.0                 |            98.26 ms |      898.30 ms |
| Scala (scalac)    | 2.11.8                |           310.81 ms |     2989.72 ms |

Evaluation
==========

I categorize the startup time for programming languages in four categories: fast, okay, slow, takes ages.

Fast
----

Fast startup times are below 1 ms on my desktop (Intel Core i5 2400S) and below 10 ms on slow
hardware (Raspberry Pi 3):

* Awk
* Bash
* C (either dynamically-linked with glibc or statically linked with musl)
* C++
* Crystal (statically linked with musl)
* D (gdc)
* Go (go)
* Haskell
* Lua
* Pascal
* Perl
* QuickJS
* Rust
* Shell (dash)

Okay
----

Okayish startup times are between 1 and 5 ms on my laptop Intel Core i7-5600U and between
10 and 50 ms on slow hardware (Raspberry Pi 3):

* CShell
* Crystal (dynamically linked with glibc)
* Dart (aot compiled to a single binary with dart2native)
* Duktape JS
* MRuby
* Python 2 (with -S)
* Ruby 1.8
* ZShell

Slow
----

Slow startup times are between 5 and 50 ms on my laptop Intel Core i7-5600U and between
50 and 500 ms on slow hardware (Raspberry Pi 3):

* C# (mcs)
* Cython (Python 2)
* Cython3 (Python 3)
* Go (gccgo)
* PHP
* Python 2
* Python 3
* Python 3 (with -S)
* PyPy (Python 2)
* Ruby (all descendents of YARV >= Ruby 1.9)

Takes ages
----------

Some programming languages take ages to start up. The startup times are above
50 ms on an Intel Core i7-5600U and over 500 ms on slow hardware
(Raspberry Pi 3):

* Java
* NodeJS
* Scala

Caveats
=======

Some misc notes on performance:

* The results are a good illustration of why we should think of runtime
  characteristics like startup performance as a function of the implementation
  of a language toolchain rather than as a function of the language itself.
  NodeJS, which is built on top of the V8 JIT JavaScript engine, had a startup
  performance of 445 ms on my system, while QuickJS came in at 0.74 ms and
  Duktape started up in 1.05 ms. The js language itself shares many
  similarities with lua, and the QuickJS and Duktape implementations are both
  lightweight and embeddable, like lua, with fast startup times for their
  interpreter. NodeJS has superior runtime performance, but its JIT engine is
  much slower to start up. This startup latency is noticeable in the startup
  latency of nodejs-based build tools and command-line utilities.

* I tested Ruby 1.8 because I was curious to see how its startup times compared
  with Ruby 2.5.x. In Ruby 1.9, the ruby interpreter switched from the original
  MRI architecture to YARV, which implemented a bytecode interpreter. I believe
  that the interpreter in Ruby <= 1.8 operated like Perl 5 by walking the AST
  rather than by generating bytecode (like python). In general, bytecode-based
  VMs tend to have better runtime performance to AST-walking interpreters, but
  they also tend to have inferior startup performance because more work needs
  to be done at startup to generate bytecode. Therefore, the performance of
  long-running ruby processes is much better in 2.5 vs 1.8, but the startup
  performance of 1.8 was significantly faster than 2.5.

* The absolte best startup performance went to a C program statically-compiled
  against musl rather than glibc. The next-fastest was freepascal, which also
  generates a small, statically-compiled binary. I have seen many benchmarks
  that generally show that C programs compiled and linked with glibc have
  superior runtime performance to programs compiled with musl, but a small
  program statically compiled with musl will have faster startup time, which
  offers advantages in some use-cases. Still, the difference on a bare-iron
  modern laptop or desktop will be < 1ms. Simplified portability and distribution
  in special-purpose environments like single-purpose embedded environments or
  containers can be a good reason to statically-link with musl, but startup
  performance is probably not a great reason to choose musl over glibc unless
  your utility is running on some type of embedded system or another
  resource-constrained environment.

* The abysmal startup performance of Scala is partly due to the fact that
  distributions of scala aren't optimized for startup time at all. On Debian,
  the ``scala`` executable is a Bash script (not dash) that does quite a bit of work
  before it invokes a scala program with the jvm. This could probably
  be optimized a bit so the startup performance is closer to java's, but
  it would still be orders of magnitude slower than the startup performance
  of a fast, lightweight interpreter like perl, awk or dash or a compiled
  language likg C, C++, Go or Rust. Anything running on a standard JVM will not
  have fast startup performance.

* The benchmarks invoke interpreted languages by executing executable
  scripts directly. This means that the OS has to read the shebang line of the
  scripts and then invoke the interpreter. I would imagine that this results in
  a slight performance penalty for all interpreted languages in these
  benchmarks, which is arguably unfair. However, executable scripts are
  generally invoked directly rather than by passing the script filename to the
  interpreter binary, and in this sense it's probably fair to compare them with
  this typical usage style.
