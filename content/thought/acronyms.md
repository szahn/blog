---
date: 2014-07-14
title: Acryonyms
type: "thought"
---

**DRY**: don’t repeat yourself. Don’t write duplicate code, instead use abstraction to abstract common things in one place.

**YAGNI**: You Ain't Gonna Need It is [the number one principle violated](https://www.telerik.com/blogs/clean-code-developer-school). Closely followed Premature Optimization , which is a special case of YAGNI.

**SOLID**: [SOLID](http://visualstudiomagazine.1105cms01.com/articles/2013/04/01/solid-agile-development.aspx) means Single responsibility, Open-closed principle, Liskov substitution, Interface segregation and Dependency inversion.

> Single Responsibility: Every object should have a single responsibility, and that all its services should be narrowly aligned with that responsibility. On some level Cohesion is considered as synonym for SRP. This principle talks about decoupling in distinct logical units with well defined boundaries (responsibilities). Logical Unit and Boundaries could be very abstract or concrete, and the boundaries depend on the context of the problem which you are trying to solve. The separation allows: To allow people to work on individual pieces of the system in isolation; To facilitate reusability; To ensure the maintainability of a system; To add new features easily; To enable everyone to better understand the system.

> Open/Closed Principle: Classes, methods or functions should be Open for extension (new functionality) and Closed for modification. This is another beautiful object oriented design principle which prevents someone from changing already tried and tested code.

> Liskov Substitution: According to Liskov Substitution Principle Subtypes must be substitutable for super type i.e. methods or functions which uses super class type must be able to work with object of sub class without any issue”. LSP is closely related to Single responsibility principle andInterface Segregation Principle. If a class has more functionality than subclass might not support some of the functionality and does violated LSP. In order to follow LSP design principle, derived class or sub class must enhance functionality not reducing it.

> Interface Segregation Principle: Interface Segregation Principle states that a client should not implement an interface if it doesn’t use that. this happens mostly when one interface contains more than one functionality and client only need one functionality and not other.Interface design is tricky job because once you release your interface you can not change it without breaking all implementation. Another benefit of this design principle in Java is, interface has disadvantage to implement all method before any class can use it so having single functionality means less method to implement. Make sure to create specific interfaces so that complexities and confusions will be kept away from end developers, and thus, the ISP will not get violated. While using inheritance take care of LSP.  It states that "Clients should not be forced to implement interfaces they don’t use." It can also be stated as "Many client specific interfaces are better than one general purpose interface." In simple words, if your interface is fat, break it into multiple interfaces. Always program for interface and not for implementation this will lead to flexible code which can work with any new implementation of interface.


