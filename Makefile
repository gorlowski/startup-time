# EXTRA_COMPILED_LANGS and EXTRA_INTERPRETED_LANGS are not in debian or ubuntu (as of 2020).
# Include them only if they already exist on this system:
EXTRA_COMPILED_LANGS := Crystal Crystal_MUSL Dart
EXTRA_INTERPRETED_LANGS := QJS Ruby18

lc = $(subst A,a,$(subst B,b,$(subst C,c,$(subst D,d,$(subst E,e,$(subst F,f,$(subst G,g,$(subst H,h,$(subst I,i,$(subst J,j,$(subst K,k,$(subst L,l,$(subst M,m,$(subst N,n,$(subst O,o,$(subst P,p,$(subst Q,q,$(subst R,r,$(subst S,s,$(subst T,t,$(subst U,u,$(subst V,v,$(subst W,w,$(subst X,x,$(subst Y,y,$(subst Z,z,$1))))))))))))))))))))))))))

OTHER_COMPILED_LANGS := $(foreach lang,$(EXTRA_COMPILED_LANGS),\
        $(if $(shell which $(call lc,$(lang))),$(lang),))

OTHER_INTERPRETED_LANGS := $(foreach lang,$(EXTRA_INTERPRETED_LANGS),\
        $(if $(shell which $(call lc,$(lang))),$(lang),))

COMPILED_LANGS := C C_MUSL C++ Cython Cython3 D Go Go_GCC Haskell OCaml Pascal Rust $(OTHER_COMPILED_LANGS)
INTERPRETED_LANGS := Awk Bash CShell DuktapeJS Lua MRuby NodeJS Perl PHP Python-S Python Python3-S Python3 PyPy Ruby Shell ZShell $(OTHER_INTERPRETED_LANGS)

GENERATED_SCRIPT_LANGUAGES := qjs djs rb18 mrb
GENERATED_INTERPRETED_SCRIPTS := $(foreach script,$(GENERATED_SCRIPT_LANGUAGES), hello-world.$(script))

Bash_EXT := bash
CShell_EXT := csh
Lua_EXT := lua
Perl_EXT := pl
PHP_EXT := php
Python_EXT := py
Python-S_EXT := py-S
Python3_EXT := py3
Python3-S_EXT := py3-S
PyPy_EXT := pypy
Ruby_EXT := rb
Ruby18_EXT := rb18
MRuby_EXT := mrb
Shell_EXT := sh
ZShell_EXT := zsh
Awk_EXT := awk
NodeJS_EXT := js
QJS_EXT := qjs
DuktapeJS_EXT := djs

C_COMPILER := gcc
C_MUSL_COMPILER := musl-gcc
C++_COMPILER := g++
Csharp_COMPILER := mcs
Cython_COMPILER := cython
Cython3_COMPILER := cython3
MONO := $(shell which mono)
D_COMPILER := gdc
Dart_COMPILER := dart2native
Go_COMPILER := go
Go_GCC_COMPILER := gccgo
Haskell_COMPILER := ghc
OCaml_COMPILER := ocamlc
Java_COMPILER := javac
Pascal_COMPILER := fpc
Rust_COMPILER := rustc
Scala_COMPILER := scalac
Crystal_COMPILER := crystal
Crystal_MUSL_COMPILER := crystal_musl

MACHINE_ARCH := $(shell uname -m)
MUSL_VERSION := $(shell /lib/ld-musl-$(MACHINE_ARCH).so.1 2>&1 |grep '^Version' |cut -d" " -f2)

Awk_VERSION = ($(shell awk --version | head -n 1 | cut -f1 -d","))
Bash_VERSION = $(shell bash --version | head -n 1 | cut -d " " -f 4 | sed 's/-release$$//')
C_VERSION = $(shell $(C_COMPILER) --version | head -n 1 | cut -d " " -f 4)
C_MUSL_VERSION = $(shell $(C_COMPILER) --version | head -n 1 | cut -d " " -f 4) / musl $(MUSL_VERSION)
C++_VERSION = $(shell $(C++_COMPILER) --version | head -n 1 | cut -d " " -f 4)
Csharp_VERSION = $(shell $(Csharp_COMPILER) --version | head -n 1 | cut -d " " -f 5)
CShell_VERSION = $(shell dpkg-query --showformat='$${Version}' --show csh | sed 's/-[a-z0-9~.]\+$$//')
Crystal_VERSION = $(shell $(Crystal_COMPILER) --version |head -n 1 | cut -d " " -f 2)
Crystal_MUSL_VERSION = $(shell $(Crystal_MUSL_COMPILER) --version |head -n 1 | cut -d " " -f 2) / musl $(MUSL_VERSION)
Cython_VERSION = $(shell $(Cython_COMPILER) --version 2>&1 | head -n 1 | cut -d " " -f 3)
Cython3_VERSION = $(shell $(Cython3_COMPILER) --version 2>&1 | head -n 1 | cut -d " " -f 3)
D_VERSION = $(shell $(D_COMPILER) --version | head -n 1 | cut -d " " -f 4)
Dart_VERSION = $(shell dart --version 2>&1 |sed -n 's/.*\([0-9]\+[.][0-9]\+[.][0-9]\+\).*/\1/p')
Go_VERSION = $(shell $(Go_COMPILER) version | head -n 1 | cut -d " " -f 3)
Go_GCC_VERSION = $(shell $(Go_GCC_COMPILER) --version | head -n 1 | cut -d " " -f 4)
Haskell_VERSION = $(shell $(Haskell_COMPILER) --version | head -n 1 | cut -d " " -f 8)
NodeJS_VERSION = $(shell /usr/bin/nodejs --version)
QJS_VERSION = (quickjs $(shell qjs -h |head -n1 |cut -d" " -f3))
DuktapeJS_VERSION = (duktape js $(shell duk -e 'var maj=Math.floor(Duktape.version / 10000), min=Math.floor(Duktape.version % 10000 / 100); pat=(Duktape.version % 100); console.log([maj,min,pat].join("."))'))
Lua_VERSION = $(shell lua -v 2>&1 | head -n 1 | cut -d " " -f 2)
Java_VERSION = $(shell $(Java_COMPILER) -version 2>&1 | head -n 1 | cut -d " " -f 2)
OCaml_VERSION = $(shell $(OCaml_COMPILER) -version)
Pascal_VERSION = $(shell $(Pascal_COMPILER) -h | head -n 1 | cut -d " " -f 5 | sed 's/\(+dfsg\)\?-[a-z0-9~.]\+$$//')
Perl_VERSION = $(shell perl --version | grep '.' | head -n 1 | sed 's/.*(v\(.*\)).*/\1/')
PHP_VERSION = $(shell php --version | head -n 1 | cut -d " " -f 2 | sed 's/-[a-z0-9~.]\+$$//')
Python_VERSION = $(shell python --version 2>&1 | head -n 1 | cut -d " " -f 2)
Python-S_VERSION = $(Python_VERSION)
Python3_VERSION = $(shell python3 --version 2>&1 | head -n 1 | cut -d " " -f 2)
Python3-S_VERSION = $(Python3_VERSION)
PyPy_VERSION = $(shell pypy --version 2>&1 | tail -n 1 | cut -d " " -f 2)
Ruby_VERSION = $(shell /usr/bin/ruby --version | head -n 1 | cut -d " " -f 2)
Ruby18_VERSION = $(shell ruby18 --version | head -n 1 | cut -d " " -f 2)
MRuby_VERSION = $(shell /usr/bin/mruby --version | head -n 1 | cut -d " " -f 2)
Rust_VERSION = $(shell $(Rust_COMPILER) --version | head -n 1 | cut -d " " -f 2)
Scala_VERSION = $(shell $(Scala_COMPILER) -version 2>&1 | head -n 1 | cut -d " " -f 4)
Shell_VERSION = $(shell printf "(%s %s)" $(shell readlink /bin/sh) $(shell dpkg-query --showformat='$${Version}' --show $(shell readlink /bin/sh) | sed 's/-.*$$//'))
ZShell_VERSION = $(shell zsh --version | head -n 1 | cut -d " " -f 2)

TIME := time -f "%e"
RUN := ./run 0 1000

define \n


endef

ifeq ($(shell id -u),0)
ROOT_CMD :=
else
ROOT_CMD := sudo
endif

CFLAGS ?= -std=gnu99 -Wall -Wextra -Werror -O3
CPPFLAGS ?= -Wall -Wextra -Werror -O3
DFLAGS ?= -Wall -O3
Go_GCC_FLAGS ?= -g -O3
HASKELL_FLAGS ?= -Wall -O3
PASCAL_FLAGS ?= -O3

PACKAGES := \
	bash \
	csh \
	cython \
	cython3 \
	default-jdk \
	duktape \
	fp-compiler \
	gcc \
	gccgo \
	gdc \
	ghc \
	golang \
	lua5.2 \
	mono-mcs \
	musl \
	nodejs \
	ocaml-nox \
	perl-base \
	php-cli \
	python \
	python3 \
	pypy \
	ruby \
	rustc \
	scala \
	zsh \
	$(NULL)

define generate_script_from_template
	@echo "#!$(shell which $(3))" > $(2)
	@sed -n '2,$$p' $(1) >> $(2)
	@chmod +x $(2)
endef

run_lang = \
	@printf "%-55s " "$(1):" $(\n)\
	@$(TIME) $(RUN) $(2) 2>&1 | tr -d '\n'$(\n)\
	@printf " ms\n"

all: $(COMPILED_LANGS) $(GENERATED_INTERPRETED_SCRIPTS) hello-world.exe HelloWorld.class HelloWorldScala.class run
	@echo 'Run on: $(shell sed -n "s/^model name\t: //p" /proc/cpuinfo | head -n 1) | $(shell . /etc/os-release; echo $$PRETTY_NAME) | $(shell date +%Y-%m-%d)'
	$(foreach lang,$(COMPILED_LANGS),$(call run_lang,$(lang) ($($(lang)_COMPILER) $($(lang)_VERSION)),./$(lang))$(\n))
	$(foreach lang,$(INTERPRETED_LANGS),$(call run_lang,$(lang) $($(lang)_VERSION),./hello-world.$($(lang)_EXT))$(\n))
	$(call run_lang,C# ($(Csharp_COMPILER) $(Csharp_VERSION)),$(MONO) ./hello-world.exe)
	$(call run_lang,Java ($(Java_COMPILER) $(Java_VERSION)),$(shell which java) HelloWorld)
	$(call run_lang,Scala ($(Scala_COMPILER) $(Scala_VERSION)),$(shell which scala) HelloWorldScala)

install:
	$(ROOT_CMD) apt-get install $(PACKAGES)

C: hello-world.c
	$(C_COMPILER) $(CFLAGS) -o $@ $^

C_MUSL: hello-world.c
	$(C_MUSL_COMPILER) -static $(CFLAGS) -o $@ $^

run: run.c
	$(C_COMPILER) $(CFLAGS) -o $@ $^

hello_cython.c: hello.pyx
	$(Cython_COMPILER) --embed -o $@ $^

Cython: hello_cython.c
	$(C_COMPILER) $(CFLAGS) -fno-strict-aliasing -o $@ $^ $(shell pkg-config --cflags --libs python-$(shell echo $(Python_VERSION) | cut -d. -f1-2))

hello_cython3.c: hello.pyx3
	$(Cython3_COMPILER) --embed -o $@ $^

Cython3: hello_cython3.c
	$(C_COMPILER) $(CFLAGS) -o $@ $^ $(shell pkg-config --cflags --libs python-$(shell echo $(Python3_VERSION) | cut -d. -f1-2))

C++: hello-world.cpp
	$(C++_COMPILER) $(CPPFLAGS) -o $@ $^

D: $(wildcard *.d)
	$(D_COMPILER) $(DFLAGS) -o $@ $^

hello-world.mrb: hello-world.rb
	$(call generate_script_from_template,$^,$@,mruby)

hello-world.rb18: hello-world.rb
	$(call generate_script_from_template,$^,$@,ruby18)

hello-world.qjs: hello-world.js
	$(call generate_script_from_template,$^,$@,qjs)

hello-world.djs: hello-world.js
	$(call generate_script_from_template,$^,$@,duk)

Crystal: hello-world.cr
	$(Crystal_COMPILER) build --release -Dno_gc -o $@ $^

Crystal_MUSL: hello-world.cr
	$(Crystal_MUSL_COMPILER) build --release -Dno_gc -o $@ $^

Dart: hello-world.dart
	$(Dart_COMPILER) -o $@ $^

Go: hello-world.go
	$(Go_COMPILER) build -o $@ $^

Go_GCC: hello-world.go
	$(Go_GCC_COMPILER) $(Go_GCC_FLAGS) -o $@ $^

Haskell: $(wildcard *.hs)
	$(Haskell_COMPILER) $(HASKELL_FLAGS) -o $@ -main-is HelloWorld $^

OCaml: hello.ml
	$(OCaml_COMPILER) -o $@ $^

Pascal: hello-world.p
	$(Pascal_COMPILER) $(PASCAL_FLAGS) -o$@ $^

Rust: hello-world.rs
	$(Rust_COMPILER) -o $@ $^

HelloWorld.class: $(wildcard *.java)
	$(Java_COMPILER) $^

HelloWorldScala.class: $(wildcard *.scala)
	$(Scala_COMPILER) $^

hello-world.exe: $(wildcard *.cs)
	$(Csharp_COMPILER) $^

clean:
	rm -f *.class *.exe *.hi *.o run hello_cython.c hello_cython3.c $(COMPILED_LANGS)

.PHONY: all clean
