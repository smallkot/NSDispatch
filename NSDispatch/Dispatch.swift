//
//  Dispatch.swift
//  NSDispatch
//

import Foundation

class DispatchGroup : DispatchObject {
    
    init()
    
    func wait(timeout: DispatchTime = default) -> Int
    
    func wait(walltime timeout: DispatchWalltime) -> Int
    
    func notify(queue: DispatchQueue, exeute block: () -> Void)
    
    func enter()
    
    func leave()
    
}

class DispatchIO : DispatchObject {
    
    enum StreamType : UInt {
        
        case stream
        
        case random
        
        typealias RawValue = UInt
        
        var hashValue: Int { get }
        
        init?(rawValue: UInt)
        
        var rawValue: UInt { get }
        
    }
    
    struct CloseFlags : OptionSet, RawRepresentable {
        
        let rawValue: UInt
        
        init(rawValue: UInt)
        
        static let stop: DispatchIO.CloseFlags
        
        typealias Element = DispatchIO.CloseFlags
        
        typealias RawValue = UInt
        
    }
    
    struct IntervalFlags : OptionSet, RawRepresentable {
        
        let rawValue: UInt
        
        init(rawValue: UInt)
        
        static let strictInterval: DispatchIO.IntervalFlags
        
        typealias Element = DispatchIO.IntervalFlags
        
        typealias RawValue = UInt
        
    }
    
    class func read(fileDescriptor: Int32, length: Int, queue: DispatchQueue, handler: (DispatchData, Int32) -> Void)
    
    class func write(fileDescriptor: Int32, data: DispatchData, queue: DispatchQueue, handler: (DispatchData?, Int32) -> Void)
    
    convenience init(type: DispatchIO.StreamType, fileDescriptor: Int32, queue: DispatchQueue, cleanupHandler: (error: Int32) -> Void)
    
    convenience init(type: DispatchIO.StreamType, path: UnsafePointer<Int8>, oflag: Int32, mode: mode_t, queue: DispatchQueue, cleanupHandler: (error: Int32) -> Void)
    
    convenience init(type: DispatchIO.StreamType, io: DispatchIO, queue: DispatchQueue, cleanupHandler: (error: Int32) -> Void)
    
    func close(flags: DispatchIO.CloseFlags)
    
    var fileDescriptor: Int32 { get }
    
    func read(offset: off_t, length: Int, queue: DispatchQueue, ioHandler io_handler: (Bool, DispatchData?, Int32) -> Void)
    
    func setHighWater(highWater high_water: Int)
    
    func setInterval(interval: UInt64, flags: DispatchIO.IntervalFlags)
    
    func setLowWater(lowWater low_water: Int)
    
    func withBarrier(barrier: () -> Void)
    
    func write(offset: off_t, data: DispatchData, queue: DispatchQueue, ioHandler io_handler: (Bool, DispatchData?, Int32) -> Void)
    
}

class DispatchObject : OS_object {
    
    func suspend()
    
    func resume()
    
    func setTargetQueue(queue: DispatchQueue?)
    
}

class DispatchQueue : DispatchObject {
    
    struct GlobalAttributes : OptionSet {
        
        let rawValue: UInt64
        
        init(rawValue: UInt64)
        
        static let qosUserInteractive: DispatchQueue.GlobalAttributes
        
        static let qosUserInitiated: DispatchQueue.GlobalAttributes
        
        static let qosDefault: DispatchQueue.GlobalAttributes
        
        static let qosUtility: DispatchQueue.GlobalAttributes
        
        static let qosBackground: DispatchQueue.GlobalAttributes
        
        typealias Element = DispatchQueue.GlobalAttributes
        
        typealias RawValue = UInt64
        
    }
    
    class var main: DispatchQueue { get }
    
    class func global(attributes: DispatchQueue.GlobalAttributes) -> DispatchQueue
    
    class func getSpecific<T>(key: DispatchSpecificKey<T>) -> T?
    
    convenience init(label: String, attributes: DispatchQueueAttributes = default, target: DispatchQueue? = default)
    
    func after(when: DispatchTime, execute work: @convention(block) () -> Void)
    
    func after(walltime when: DispatchWalltime, execute work: @convention(block) () -> Void)
    
    func apply(applier iterations: Int, execute block: @noescape (Int) -> Void)
    
    func asynchronously(execute workItem: DispatchWorkItem)
    
    func asynchronously(group: DispatchGroup? = default, qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, execute work: @convention(block) () -> Void)
    
    var label: String { get }
    
    func synchronously(execute block: @noescape () -> Void)
    
    func synchronously(execute workItem: DispatchWorkItem)
    
    func synchronously<T>(execute work: @noescape () throws -> T) rethrows -> T
    
    func synchronously<T>(flags: DispatchWorkItemFlags, execute work: @noescape () throws -> T) rethrows -> T
    
    var qos: DispatchQoS { get }
    
    func getSpecific<T>(key: DispatchSpecificKey<T>) -> T?
    
    func setSpecific<T>(key: DispatchSpecificKey<T>, value: T)
    
}

@noreturn
func dispatchMain()

class DispatchSemaphore : DispatchObject {
    
    init(value: Int)
    
    func wait(timeout: DispatchTime = default) -> Int
    
    func wait(walltime timeout: DispatchWalltime) -> Int
    
    func signal() -> Int
    
}

class DispatchSource : DispatchObject {
    
    struct MachSendEvent : OptionSet, RawRepresentable {
        
        let rawValue: UInt
        
        init(rawValue: UInt)
        
        static let dead: DispatchSource.MachSendEvent
        
        typealias Element = DispatchSource.MachSendEvent
        
        typealias RawValue = UInt
        
    }
    
    struct MemoryPressureEvent : OptionSet, RawRepresentable {
        
        let rawValue: UInt
        
        init(rawValue: UInt)
        
        static let normal: DispatchSource.MemoryPressureEvent
        
        static let warning: DispatchSource.MemoryPressureEvent
        
        static let critical: DispatchSource.MemoryPressureEvent
        
        static let all: DispatchSource.MemoryPressureEvent
        
        typealias Element = DispatchSource.MemoryPressureEvent
        
        typealias RawValue = UInt
        
    }
    
    struct ProcessEvent : OptionSet, RawRepresentable {
        
        let rawValue: UInt
        
        init(rawValue: UInt)
        
        static let exit: DispatchSource.ProcessEvent
        
        static let fork: DispatchSource.ProcessEvent
        
        static let exec: DispatchSource.ProcessEvent
        
        static let signal: DispatchSource.ProcessEvent
        
        static let all: DispatchSource.ProcessEvent
        
        typealias Element = DispatchSource.ProcessEvent
        
        typealias RawValue = UInt
        
    }
    
    struct TimerFlags : OptionSet, RawRepresentable {
        
        let rawValue: UInt
        
        init(rawValue: UInt)
        
        static let strict: DispatchSource.TimerFlags
        
        typealias Element = DispatchSource.TimerFlags
        
        typealias RawValue = UInt
        
    }
    
    struct FileSystemEvent : OptionSet, RawRepresentable {
        
        let rawValue: UInt
        
        init(rawValue: UInt)
        
        static let delete: DispatchSource.FileSystemEvent
        
        static let write: DispatchSource.FileSystemEvent
        
        static let extend: DispatchSource.FileSystemEvent
        
        static let attrib: DispatchSource.FileSystemEvent
        
        static let link: DispatchSource.FileSystemEvent
        
        static let rename: DispatchSource.FileSystemEvent
        
        static let revoke: DispatchSource.FileSystemEvent
        
        static let all: DispatchSource.FileSystemEvent
        
        typealias Element = DispatchSource.FileSystemEvent
        
        typealias RawValue = UInt
        
    }
    
    class func machSend(port: mach_port_t, eventMask: DispatchSource.MachSendEvent, queue: DispatchQueue? = default) -> DispatchSourceMachSend
    
    class func machReceive(port: mach_port_t, queue: DispatchQueue? = default) -> DispatchSourceMachReceive
    
    class func memoryPressure(eventMask: DispatchSource.MemoryPressureEvent, queue: DispatchQueue? = default) -> DispatchSourceMemoryPressure
    
    class func process(identifier: pid_t, eventMask: DispatchSource.ProcessEvent, queue: DispatchQueue? = default) -> DispatchSourceProcess
    
    class func read(fileDescriptor: Int32, queue: DispatchQueue? = default) -> DispatchSourceRead
    
    class func signal(signal: Int32, queue: DispatchQueue? = default) -> DispatchSourceSignal
    
    class func timer(flags: DispatchSource.TimerFlags = default, queue: DispatchQueue? = default) -> DispatchSourceTimer
    
    class func userDataAdd(queue: DispatchQueue? = default) -> DispatchSourceUserDataAdd
    
    class func userDataOr(queue: DispatchQueue? = default) -> DispatchSourceUserDataOr
    
    class func fileSystemObject(fileDescriptor: Int32, eventMask: DispatchSource.FileSystemEvent, queue: DispatchQueue? = default) -> DispatchSourceFileSystemObject
    
    class func write(fileDescriptor: Int32, queue: DispatchQueue? = default) -> DispatchSourceWrite
    
}

protocol DispatchSourceType : NSObjectProtocol {
    
    typealias DispatchSourceHandler = @convention(block) () -> Void
    
    func setEventHandler(handler: DispatchSourceHandler?)
    
    func setCancelHandler(handler: DispatchSourceHandler?)
    
    func setRegistrationHandler(handler: DispatchSourceHandler?)
    
    func cancel()
    
    func resume()
    
    func suspend()
    
    var handle: UInt { get }
    
    var mask: UInt { get }
    
    var data: UInt { get }
    
    var isCancelled: Bool { get }
    
}

extension DispatchSource : DispatchSourceType {
    
}

protocol DispatchSourceUserDataAdd : DispatchSourceType {
    
    func mergeData(value: UInt)
    
}

extension DispatchSource : DispatchSourceUserDataAdd {
    
}

protocol DispatchSourceUserDataOr : DispatchSourceType {
    
    func mergeData(value: UInt)
    
}

extension DispatchSource : DispatchSourceUserDataOr {
    
}

protocol DispatchSourceMachSend : DispatchSourceType {
    
    var handle: mach_port_t { get }
    
    var data: DispatchSource.MachSendEvent { get }
    
    var mask: DispatchSource.MachSendEvent { get }
    
}

extension DispatchSource : DispatchSourceMachSend {
    
}

protocol DispatchSourceMachReceive : DispatchSourceType {
    
    var handle: mach_port_t { get }
    
}

extension DispatchSource : DispatchSourceMachReceive {
    
}

protocol DispatchSourceMemoryPressure : DispatchSourceType {
    
    var data: DispatchSource.MemoryPressureEvent { get }
    
    var mask: DispatchSource.MemoryPressureEvent { get }
    
}

extension DispatchSource : DispatchSourceMemoryPressure {
    
}

protocol DispatchSourceProcess : DispatchSourceType {
    
    var handle: pid_t { get }
    
    var data: DispatchSource.ProcessEvent { get }
    
    var mask: DispatchSource.ProcessEvent { get }
    
}

extension DispatchSource : DispatchSourceProcess {
    
}

protocol DispatchSourceRead : DispatchSourceType {
    
}

extension DispatchSource : DispatchSourceRead {
    
}

protocol DispatchSourceSignal : DispatchSourceType {
    
}

extension DispatchSource : DispatchSourceSignal {
    
}

protocol DispatchSourceTimer : DispatchSourceType {
    
    func setTimer(start: DispatchTime, leeway: DispatchTimeInterval = default)
    
    func setTimer(walltime start: DispatchWalltime, leeway: DispatchTimeInterval = default)
    
    func setTimer(start: DispatchTime, interval: DispatchTimeInterval, leeway: DispatchTimeInterval = default)
    
    func setTimer(start: DispatchTime, interval: Double, leeway: DispatchTimeInterval = default)
    
    func setTimer(walltime start: DispatchWalltime, interval: DispatchTimeInterval, leeway: DispatchTimeInterval = default)
    
    func setTimer(walltime start: DispatchWalltime, interval: Double, leeway: DispatchTimeInterval = default)
    
}

extension DispatchSource : DispatchSourceTimer {
    
}

protocol DispatchSourceFileSystemObject : DispatchSourceType {
    
    var handle: Int32 { get }
    
    var data: DispatchSource.FileSystemEvent { get }
    
    var mask: DispatchSource.FileSystemEvent { get }
    
}

extension DispatchSource : DispatchSourceFileSystemObject {
    
}

protocol DispatchSourceWrite : DispatchSourceType {
    
}

extension DispatchSource : DispatchSourceWrite {
    
}

extension DispatchSourceMemoryPressure {
    
    var data: DispatchSource.MemoryPressureEvent { get }
    
    var mask: DispatchSource.MemoryPressureEvent { get }
    
}

extension DispatchSourceMachReceive {
    
    var handle: mach_port_t { get }
    
}

extension DispatchSourceFileSystemObject {
    
    var handle: Int32 { get }
    
    var data: DispatchSource.FileSystemEvent { get }
    
    var mask: DispatchSource.FileSystemEvent { get }
    
}

extension DispatchSourceUserDataOr {
    
    func mergeData(value: UInt)
    
}

struct DispatchData : RandomAccessCollection, _ObjectiveCBridgeable {
    
    typealias Iterator = DispatchDataIterator
    
    typealias Index = Int
    
    typealias Indices = DefaultRandomAccessIndices<DispatchData>
    
    static let empty: DispatchData
    
    enum Deallocator {
        
        case free
        
        case unmap
        
        case custom(DispatchQueue?, @convention(block) () -> Void)
        
    }
    
    init(bytes buffer: UnsafeBufferPointer<UInt8>)
    
    init(bytesNoCopy bytes: UnsafeBufferPointer<UInt8>, deallocator: DispatchData.Deallocator = default)
    
    var count: Int { get }
    
    func withUnsafeBytes<Result, ContentType>(body: @noescape (UnsafePointer<ContentType>) throws -> Result) rethrows -> Result
    
    func enumerateBytes(block: @noescape (buffer: UnsafeBufferPointer<UInt8>, byteIndex: Int, stop: inout Bool) -> Void)
    
    mutating func append(_ bytes: UnsafePointer<UInt8>, count: Int)
    
    mutating func append(_ other: DispatchData)
    
    mutating func append<SourceType>(_ buffer: UnsafeBufferPointer<SourceType>)
    
    func copyBytes(to pointer: UnsafeMutablePointer<UInt8>, count: Int)
    
    func copyBytes(to pointer: UnsafeMutablePointer<UInt8>, from range: CountableRange<Index>)
    
    func copyBytes<DestinationType>(to buffer: UnsafeMutableBufferPointer<DestinationType>, from range: CountableRange<Index>? = default) -> Int
    
    subscript(index: Index) -> UInt8 { get }
    
    subscript(bounds: Range<Int>) -> RandomAccessSlice<DispatchData> { get }
    
    func subdata(in range: CountableRange<Index>) -> DispatchData
    
    func region(location: Int) -> (data: DispatchData, offset: Int)
    
    var startIndex: Index { get }
    
    var endIndex: Index { get }
    
    func index(before i: Index) -> Index
    
    func index(after i: Index) -> Index
    
    func makeIterator() -> Iterator
    
    typealias IndexDistance = Int
    
    typealias _Element = UInt8
    
    typealias SubSequence = RandomAccessSlice<DispatchData>
    
    typealias _ObjectiveCType = __DispatchData
    
}

struct DispatchDataIterator : IteratorProtocol, Sequence {
    
    mutating func next() -> _Element?
    
    typealias Element = _Element
    
    typealias Iterator = DispatchDataIterator
    
    typealias SubSequence = AnySequence<_Element>
    
}

struct DispatchQoS : Equatable {
    
    let qosClass: DispatchQoS.QoSClass
    
    let relativePriority: Int
    
    static let background: DispatchQoS
    
    static let utility: DispatchQoS
    
    static let defaultQoS: DispatchQoS
    
    static let userInitiated: DispatchQoS
    
    static let userInteractive: DispatchQoS
    
    static let unspecified: DispatchQoS
    
    enum QoSClass {
        
        case background
        
        case utility
        
        case defaultQoS
        
        case userInitiated
        
        case userInteractive
        
        case unspecified
        
        var hashValue: Int { get }
        
    }
    
    init(qosClass: DispatchQoS.QoSClass, relativePriority: Int)
    
}

infix func ==(a: DispatchQoS.QoSClass, b: DispatchQoS.QoSClass) -> Bool

func ==(a: DispatchQoS, b: DispatchQoS) -> Bool

infix func ==(a: DispatchQoS.QoSClass, b: DispatchQoS.QoSClass) -> Bool

struct DispatchQueueAttributes : OptionSet {
    
    let rawValue: UInt64
    
    init(rawValue: UInt64)
    
    static let serial: DispatchQueueAttributes
    
    static let concurrent: DispatchQueueAttributes
    
    static let qosUserInteractive: DispatchQueueAttributes
    
    static let qosUserInitiated: DispatchQueueAttributes
    
    static let qosDefault: DispatchQueueAttributes
    
    static let qosUtility: DispatchQueueAttributes
    
    static let qosBackground: DispatchQueueAttributes
    
    static let noQoS: DispatchQueueAttributes
    
    typealias Element = DispatchQueueAttributes
    
    typealias RawValue = UInt64
    
}

final class DispatchSpecificKey<T> {
    
    init()
    
}

struct DispatchTime {
    
    let rawValue: dispatch_time_t
    
    static func now() -> DispatchTime
    
    static let distantFuture: DispatchTime
    
}

enum DispatchTimeInterval {
    
    case seconds(Int)
    
    case milliseconds(Int)
    
    case microseconds(Int)
    
    case nanoseconds(Int)
    
}

struct DispatchWalltime {
    
    let rawValue: dispatch_time_t
    
    static func now() -> DispatchWalltime
    
    static let distantFuture: DispatchWalltime
    
    init(time: timespec)
    
}

func +(time: DispatchTime, interval: DispatchTimeInterval) -> DispatchTime

func +(time: DispatchTime, seconds: Double) -> DispatchTime

func +(time: DispatchWalltime, interval: DispatchTimeInterval) -> DispatchWalltime

func +(time: DispatchWalltime, seconds: Double) -> DispatchWalltime

func -(time: DispatchTime, interval: DispatchTimeInterval) -> DispatchTime

func -(time: DispatchTime, seconds: Double) -> DispatchTime

func -(time: DispatchWalltime, interval: DispatchTimeInterval) -> DispatchWalltime

func -(time: DispatchWalltime, seconds: Double) -> DispatchWalltime

class DispatchWorkItem {
    
    init(group: DispatchGroup? = default, qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, block: () -> ())
    
    func perform()
    
    func wait(timeout: DispatchTime = default) -> Int
    
    func wait(timeout: DispatchWalltime) -> Int
    
    func notify(queue: DispatchQueue, execute: @convention(block) () -> Void)
    
    func cancel()
    
    var isCancelled: Bool { get }
    
}

struct DispatchWorkItemFlags : OptionSet, RawRepresentable {
    
    let rawValue: UInt
    
    init(rawValue: UInt)
    
    static let barrier: DispatchWorkItemFlags
    
    static let detached: DispatchWorkItemFlags
    
    static let assignCurrentContext: DispatchWorkItemFlags
    
    static let noQoS: DispatchWorkItemFlags
    
    static let inheritQoS: DispatchWorkItemFlags
    
    static let enforceQoS: DispatchWorkItemFlags
    
    typealias Element = DispatchWorkItemFlags
    
    typealias RawValue = UInt
    
}
