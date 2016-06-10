# NSDispatch

![Objective-C](https://img.shields.io/badge/lang-Obj--C-438EFF.svg)
![Platform](https://img.shields.io/badge/platform-iOS%20%2F%20OS%20X-lightgrey.svg)
![CocoaPods](https://img.shields.io/cocoapods/v/NSDispatch.svg)

NSDispatch is an Objective-C wrapper for libispatch. NSDispatch's class and method names are based off of the [official Apple implementation of libdispatch for Swift 3](https://github.com/apple/swift-evolution/blob/master/proposals/0088-libdispatch-for-swift3.md), and use Objective-C and Cocoa API naming conventions.

NSDispatch is forked from [GCDObjC](https://github.com/mjmsmith/gcdobjc), who's four main aims are to:

* Organize the flat C API into appropriate classes.
* Use intention-revealing names to distinguish between synchronous and asynchronous functions. 
* Use more convenient arguments such as time intervals.
* Add convenience methods.

## Usage

NSDispatch requires ARC. `NSDispatch.h` is the only header file that needs to be imported. For usage examples, see `NSDispatchTests.m`.

To install NSDispatch via CocoaPods:

- Add `pod 'NSDispatch'` to your podfile.
- In Terminal, `cd /your-project-directory/` and type `pod install`.
- Use the `.workspace` file that CocoaPods generates when working on your project from this point on.

## Warning

This project uses the `NS` namespace for it's classes. Typically this namespace is typically [reserved for Apple classes](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Conventions/Conventions.html) in Objective-C. However, the only point of this fun and quick little prtoject was to look, read, and behave as if it was an Apple created library for concurency. Changing the namespace to anything but `NS` would defeat the purpose of the project.

It is very unlikely that Apple will ever make any classes using the designator `NSDispatch`, however if you are concerned about future compatibility because of something Apple might change then you should do one of the following things:
- Use the project NSDispatch was forked from, [GDCObjC](https://github.com/mjmsmith/gcdobjc). They are already extremely similar. The main thing that was changed in this fork is the naming schemes.
- Use one of the [many](https://github.com/Tricertops/Grand-Object-Dispatch) [other](https://github.com/rsms/LazyDispatch) existing `libdispatch` Objective-C wrappers avaliable.
- Feel free to fork NSDispatch and change the class namespaces to some other two-or-three-letter designator and continue using it to your heart's desire.

On the off chance than Apple ever does make an `NSDispatch` class/library, I will immediately deprecate this project.

This code is provided as-is. Include it in your own projects at your own risk.
