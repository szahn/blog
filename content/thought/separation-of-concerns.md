---
date: 204-08-21
title: Separation of Concerns
type: "thought"
---

A key tenant of building cross-platform apps is to create an architecture that lends itself to a maximization of code sharing across platforms. Adhering to the following Object Oriented Programming principles helps build a well-architected application:

[Separation of concerns](http://effectivesoftwaredesign.com/2012/02/05/separation-of-concerns/) is a concept that, when applied to software development, deals with creating distance between dissimilar aspects of your code. This may seem like a complicated statement, but we all have dealt with it in the past, even if we haven’t known it. You’ve probably heard that you shouldn’t have your data access code in your Web page. That is separation of concerns. The Web page shouldn’t directly know how to deal with database concerns like connection strings, command objects, and so on. 

The most important principle in Software Engineering is the [Separation of Concerns](http://weblogs.asp.net/arturtrosin/archive/2009/01/26/separation-of-concern-vs-single-responsibility-principle-soc-vs-srp.aspx) (SoC): The idea that a software system must be decomposed into parts that overlap in functionality as little as possible. It is so central that it appears in many different forms in the evolution of all methodologies, programming languages and best practices.

Dijkstra mentions it in 1974: "separation of concerns … even if not perfectly possible is yet the only available technique for effective ordering of one’s thoughts". Information Hiding, defined by Parnas in 1972, focuses on reducing the dependency between modules through the definition of clear interfaces. A further improvement was Abstract Data Types (ADT), by Liskov in 1974, which integrated data and functions in a single definition.

Complex code gets out of hand when you don't partition it properly. Code becomes heavily intermixed, making it error prone, difficult to maintain, and hard to learn, only serving to worsen the problem as you bring new developers into the party! Creating modules or libraries to share common calculations or processes among different parts of your application is often the first step in 'code re-use'. Which is of course, a very good thing!

To avoid duplicating code, place members into their appropriate namespace and class such that the class only has one reason to change. The ultimate goal when applying separation of concerns is maintainability. 

The value of separation of concerns is simplifying development and maintenance of computer programs. When concerns are well separated, individual sections can be developed and updated independently. Of especial value is the ability to later improve or modify one section of code without having to know the details of other sections, and without having to make corresponding changes to those sections.

- Albert Einstein stated, "Make everything as simple as possible, but not simpler." 
- The overall goal of Separation of Concerns is to establish a well organized system where each part fulfills a meaningful and intuitive role while maximizing its ability to adapt to change
- You can’t get rid of complexity, you can only shift it and hide it.
- Complex things are made up of infinitely simpler  things. 
- Through proper separation of concerns, complexity becomes manageable.  
- System elements should have exclusivity and singularity of purpose.
- Separation of concerns is achieved by the establishment of boundaries. In code, we call those boundaries namespaces, scope, class and methods. Some examples of boundaries would include the use of methods, objects, components, and services to define core behavior within an application; projects, solutions, and folder hierarchies for source organization; application layers and tiers for processing organization; and versioned libraries.
- [The goal is not to reduce a system into its indivisible parts](http://aspiringcraftsman.com/2008/01/03/art-of-separation-of-concerns/), but to organize the system into elements of non-repeating sets of cohesive responsibilities.


## Horizontal Separation

Horizontal Separation of Concerns refers to the process of dividing an application into logical layers of functionally that fulfill the same role within the application. For example: presentation layer, business layer, data layer

## Vertical Separation

Vertical Separation of Concerns refers to the process of dividing an application into modules of functionality that relate to the same feature or sub-system within an application.

Aspect Separation of Concerns, better known as Aspect-Oriented Programming, refers to the process of segregating an application’s cross-cutting concerns from its core concerns. Cross-cutting concerns, or aspects, are concerns which are interspersed across multiple boundaries within an application. Logging is one example of an activity performed across many system components.

## Encapsulation

Ensuring that classes and even architectural layers only expose a minimal API that performs their required functions, and hides the implementation details. At a class level, this means that objects behave as ‘black boxes’ and that consuming code does not need to know how they accomplish their tasks. At an architectural level, it means implementing patterns like Façade that encourage a simplified API that orchestrates more complex interactions on behalf of the code in more abstract layers. This means that the UI code (for example) should only be responsible for displaying screens and accepting user-input; and never interacting with the database directly. Similarly the data-access code should only read and write to the database, but never interact directly with buttons or labels.

Encapsulate what varies. Only one thing is constant in the software field and that is “Change”, so encapsulate the code you expect to be changed in future. The benefit of this principle is that Its easy to test and maintain proper encapsulated code. Follow principle of making variable and methods private by default and increasing access step by step e.g. from private to protected and not public. Several design patterns use encapsulation, such as the Factory design pattern which encapsulates object creation code and provides flexibility to introduce new products later with no impact on existing code.


## Separation of Responsibilities

Ensure that each component (both at architectural and class level) has a clear and well-defined purpose. Each component should perform only its defined tasks and expose that functionality via an API that is accessible to the other classes that need to use it.

## Polymorphism 

Programming to an interface (or abstract class) that supports multiple implementations means that core code can be written and shared across platforms, while still interacting with platform-specific features.

The natural outcome is an application modeled after real world or abstract entities with separate logical layers. Separating code into layers make applications easier to understand, test and maintain. It is recommended that the code in each layer be physically separate (either in directories or even separate projects for very large applications) as well as logically separate (using namespaces). is the process of breaking a computer program into distinct features that overlap in functionality as little as possible. A concern is any piece of interest or focus in a program. Typically, concerns are synonymous with features or behaviors.

Why was it important to separate these two responsibilities into separate classes? Because each responsibility is an axis of change. When the requirements change, that change will be manifest through a change in responsibility amongst the classes. If a class assumes more than one responsibility, then there will be more than one reason for it to change. If a class has more then one responsibility, then the responsibilities become coupled. Changes to one responsibility may impair or inhibit the class’ ability to meet the others. This kind of coupling leads to fragile designs that break in unexpected ways when changed.
