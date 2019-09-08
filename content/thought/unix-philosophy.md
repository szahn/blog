---
date: 2014-06-15
title: Unix Philosophy
type: "thought"
---

> [Write programs that do one thing and do it well](http://www.catb.org/esr/writings/taoup/html/ch01s06.html).
Write programs to work together.
Write programs to handle text streams, because that is a universal interface.


McIlroy’s slightly longer original 4-point formulation is this:

- Make each program do one thing well. To do a new job, build afresh rather than complicate old programs by adding new features.
- Expect the output of every program to become the input to another, as yet unknown, program. Don’t clutter output with extraneous information. Avoid stringently columnar or binary input formats. Don’t insist on interactive input.
- Design and build software, even operating systems, to be tried early, ideally within weeks. Don’t hesitate to throw away the clumsy parts and rebuild them.
- Use tools in preference to unskilled help to lighten a programming task, even if you have to detour to build the tools and expect to throw some of them out after you’ve finished using them.



> Small is beautiful.
Make each program do one thing well.
Build a prototype as soon as possible.
Choose portability over efficiency.
Store data in flat text files.
Use software leverage to your advantage.
Use shell scripts to increase leverage and portability.
Avoid captive user interfaces.
Make every program a filter.


> Write modules that do one thing well. Write a new module rather than complicate an old one.
Write modules that encourage composition rather than extension.
Write modules that handle data Streams, because that is the universal interface.
Write modules that are agnostic about the source of their input or the destination of their output.
Write modules that solve a problem you know, so you can learn about the ones you don’t.
Write modules that are small. Iterate quickly. Refactor ruthlessly. Rewrite bravely.
Write modules quickly, to meet your needs, with just a few tests for compliance. Avoid extensive specifications. Add a test for each bug you fix.
Write modules for publication, even if you only use them privately. You will appreciate documentation in the future.
Working is better than perfect.
Focus is better than features.
Compatibility is better than purity.
Simplicity is better than anything.
