---
date: 2012-06-12
title: Object Oriented Programming
type: "thought"
---

In the object oriented world we only see objects. Objects interact with each other. Classes, Objects, Inheritance, Polymorphism, Abstraction are common vocabulary we hear in our day-to-day careers.
Software architecture like MVC, 3-Tier, MVP tells us how overall projects are going to be structured. MVC (or model view controller) is also a form of a design pattern.

Design patterns allows us to reuse the experience or rather, provides reusable solutions to commonly occurring problems. Example – an object creation problem, an instance management problem, etc. Design patterns are helpful in providing a common vocabulary among developers such that they can discuss implementation details.

Principles tell us, do these and you will achieve this. How you will do it is up to you. Everyone defines some principles in their lives like, "I never lie," or, "I never drink alcohol," etc. He/she follow these principles to make his/her life easy, but how will he/she stick to these principles is up to the individual. In the same way, object oriented design is filled with many principles which let us manage the problems with software design.

Polymorphism enables a developer to remove hardcoded "if" statements. For example, you might have types like Employee, Manager, Executive. They all have a `GetPaid` method. Polymorphism would allow an array of these types to be iterated, and all you would have to do to pay everyone is call `x.GetPaid();` Without polymorphism, you have to do logic like: If Employee, pay this way. If Manager, pay that way. If Executive, pay another way.

An abstract class is an incomplete class definition. It cannot be instantiated on it's own. However, an abstract class can contain implementations whereas an interface can only define a method or property without implementation. 

See [Principles of OOP](http://www.butunclebob.com/ArticleS.UncleBob.PrinciplesOfOod).