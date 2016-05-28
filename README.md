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

NSDispatch requires ARC and iOS 9.0. `NSDispatch.h` is the only header file that needs to be imported. For usage examples, see `NSDispatchTests.m`.

To install NSDispatch via CocoaPods:

- Add `pod 'NSDispatch'` to your podfile.
- In Terminal, `cd /your-project-directory/` and type `pod install`.
- Use the `.workspace` file that CocoaPods generates when working on your project from this point on.
