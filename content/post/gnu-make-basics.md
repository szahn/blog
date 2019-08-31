---
date: 2018-12-04
tags: [linux, devops]
draft: false
title: Make for Windows Developers
ThumbUrl: img/gnu-icon.png
---

How do modern developers chain complex commands together to build software products? Javascript developers may tend to use [NPM scripts](https://docs.npmjs.com/misc/scripts), Windows developers may use  a more object oriented approach with Powershell. However, `Make` is the tried and true approach for most build pipelines. With the advent of [WSL](https://docs.microsoft.com/en-us/windows/wsl/faq), what used to be reserved for Linux developers, can now be used universally as a basic build command tool on all major operating systems.

# Prerequisites

There are several versions of make available, like [CMake](https://cmake.org/) some better than others. If you are on OSX, you'll need to install the XCode Command Line Tools. Ubuntu should already have make installed. On a Linux debian system like Ubuntu, if you don't already have `make`, run `sudo apt-get install build-essential`. On Windows, you should download the WSL.



# Make Basics

A Makefile is a plain text file that is tab sensitive. Meaning, commannds are separated by tabs and line breaks, therefore, it's important to use an editor with the correct encoding. The basic structure of a modern Makefile might look like the following. A makefile basically is a better way to organize a bunch of shell scripts. Each make command basically just spins up it's own shell process.

```Makefile

clean:
    @echo "Cleaning build"

build: clean
    @npm run build

run: build
    @sudo docker run -it alpine

```

To run this Makefile, just type `make run` on the console.

Create a `Makefile` on your project root folder and start writing build commands. You can chain them together, introduce environment variables and even nest makefiles to call then recursively. Below is an example of one that does a variety of things.

```Makefile
# Gets the version from the initialized git repository
version:=$(shell git rev-parse --short HEAD)

# Prints the version
print_version:
	@echo "Commit: ${version}"
```

# A Real World Example

I actually use make to build my Hugo blog and below is what the build process looks like. So, building and publishing my blog to AWS S3 as a static site is as simple as calling `make deploy -B`.

```Makefile
clean:
	rm -rf public

publish: clean
	hugo -s ./

serve:
	hugo server -wDs ./ -d dev & xdg-open http://localhost:1313/

deploy: publish
	aws s3 cp public/ s3://blog.stuartzahn.net --recursive  --include "*" --acl public-read
```
