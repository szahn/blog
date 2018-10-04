---
date: 2014-04-22
tags: [.net]
title: Analyzing .NET Assembly Architecture
---

Have you ever installed an IIS website only to get an error that there is an assembly with the incorrect format in the bin folder? How about when you're installing a window service and you're not sure if the application is 32-bit or 64-bit? Sure, there are free tools like the Telerik Decompiler that will let you poke around those .dlls to see what cpu architecture they are built for, but what if you have dozens of dlls in one folder?

This utility will dump a list of all .Net assemblies in a folder and display their CPU architecture.

It can be found on GitHub here: https://github.com/szahn/AssemblyAnalyzer

The utility works by querying the ProcessorArchitecture (http://msdn.microsoft.com/en-us/library/vstudio/system.reflection.processorarchitecture) attribute using reflection.