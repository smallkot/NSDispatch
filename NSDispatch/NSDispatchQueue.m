//
//  NSDispatchQueue.m
//  NSDispatch
//

#import "NSDispatchGroup.h"
#import "NSDispatchQueue.h"

static NSDispatchQueue *mainQueue;
static NSDispatchQueue *globalQueue;
static NSDispatchQueue *highPriorityGlobalQueue;
static NSDispatchQueue *lowPriorityGlobalQueue;
static NSDispatchQueue *backgroundPriorityGlobalQueue;

@interface NSDispatchQueue ()
@property (strong, readwrite, nonatomic) dispatch_queue_t queue;
@end

@implementation NSDispatchQueue

#pragma mark Global queue accessors.

+ (NSDispatchQueue *)mainQueue {
    return mainQueue;
}

+ (instancetype)globalQueue:(NSDispatchQueuePriority)priority {
    switch (priority) {
        case NSDispatchQueuePriorityDefault:
            return globalQueue;
        case NSDispatchQueuePriorityBackground:
            return backgroundPriorityGlobalQueue;
        case NSDispatchQueuePriorityLow:
            return lowPriorityGlobalQueue;
        case NSDispatchQueuePriorityHigh:
            return highPriorityGlobalQueue;
    }
}

#pragma mark Lifecycle.

+ (void)initialize {
    if (self == [NSDispatchQueue class]) {
        mainQueue = [[NSDispatchQueue alloc] initWithDispatchQueue:dispatch_get_main_queue()];
        globalQueue = [[NSDispatchQueue alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
        highPriorityGlobalQueue = [[NSDispatchQueue alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)];
        lowPriorityGlobalQueue = [[NSDispatchQueue alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)];
        backgroundPriorityGlobalQueue = [[NSDispatchQueue alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)];
    }
}

+ (instancetype)queueWithName:(NSString *)name attributes:(dispatch_queue_attr_t)attrs {
    return [[self alloc] initWithDispatchQueue:dispatch_queue_create(nil, attrs)];
}

+ (instancetype)serialQueueWithName:(NSString *)name {
    return [self queueWithName:name attributes:DISPATCH_QUEUE_SERIAL];
}

+ (instancetype)concurrentQueueWithName:(NSString *)name {
    return [self queueWithName:name attributes:DISPATCH_QUEUE_CONCURRENT];
}

- (instancetype)initWithDispatchQueue:(dispatch_queue_t)queue {
    self = [super init];
    if (self) {
        self.queue = queue;
    }
    
    return self;
}

- (instancetype)init {
    return [self initWithDispatchQueue:dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL)];
}

#pragma mark Public block methods.

- (void)asynchronously:(dispatch_block_t)block {
    dispatch_async(self.queue, block);
}

- (void)execute:(dispatch_block_t)block after:(dispatch_time_t)time withDelay:(NSTimeInterval)seconds {
    dispatch_after(dispatch_time(time, (seconds * NSEC_PER_SEC)), self.queue, block);
}

- (void)execute:(dispatch_block_t)block afterDelay:(NSTimeInterval)seconds {
    [self execute:block after:DISPATCH_TIME_NOW withDelay:seconds];
}

- (void)synchronously:(dispatch_block_t)block {
    dispatch_sync(self.queue, block);
}

- (void)synchronously:(void (^)(size_t))block iterationCount:(size_t)count {
    dispatch_apply(count, self.queue, block);
}

- (void)asynchronously:(dispatch_block_t)block inGroup:(NSDispatchGroup *)dispatchGroup {
    dispatch_group_async(dispatchGroup.group, self.queue, block);
}

- (void)notify:(dispatch_block_t)block inGroup:(NSDispatchGroup *)dispatchGroup {
    dispatch_group_notify(dispatchGroup.group, self.queue, block);
}

- (void)barrierAsynchronously:(dispatch_block_t)block {
    dispatch_barrier_async(self.queue, block);
}

- (void)barrierSynchronously:(dispatch_block_t)block {
    dispatch_barrier_sync(self.queue, block);
}

#pragma mark Misc public methods.

- (void)suspend {
    dispatch_suspend(self.queue);
}

- (void)resume {
    dispatch_resume(self.queue);
}

@end
