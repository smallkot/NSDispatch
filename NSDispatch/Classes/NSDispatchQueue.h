//
//  NSDispatchQueue.h
//  NSDispatch
//

#import <Foundation/Foundation.h>

@class NSDispatchGroup;

typedef NS_ENUM(NSUInteger, NSDispatchQueuePriority)
{
    NSDispatchQueuePriorityDefault    = DISPATCH_QUEUE_PRIORITY_DEFAULT,
    NSDispatchQueuePriorityBackground = DISPATCH_QUEUE_PRIORITY_BACKGROUND,
    NSDispatchQueuePriorityLow        = DISPATCH_QUEUE_PRIORITY_LOW,
    NSDispatchQueuePriorityHigh       = DISPATCH_QUEUE_PRIORITY_HIGH
};

@interface NSDispatchQueue : NSObject

/** The underlying dispatch queue object. */
@property (strong, readonly, nonatomic) dispatch_queue_t queue;

#pragma mark Existing queues

/**
 *  @brief The serial dispatch queue associated with the application's main thread.
 *  @discussion This queue is created automatically on behalf of the main thread before main is called.
 *  @see dispatch_get_main_queue()
 */
+ (instancetype)mainQueue;

/**
 *  @return The global queue with the given priority.
 *  @see dispatch_get_global_queue()
 */
+ (instancetype)globalQueue:(NSDispatchQueuePriority)priority;

#pragma mark Making queues

/**
 *  Creates a new queue with the given name and attributes.
 *  @see dispatch_queue_create()
 */
+ (instancetype)queueWithName:(NSString *)name attributes:(dispatch_queue_attr_t)attrs;

/**
 *  Creates a new serial queue.
 *  @see dispatch_queue_create()
 */
+ (instancetype)serialQueueWithName:(NSString *)name;

/**
 *  Creates a new concurrent queue.
 *  @see dispatch_queue_create()
 */
+ (instancetype)concurrentQueueWithName:(NSString *)name;

/**
 *  Creates a new queue object given an existing dispatch_queue_t.
 *  @param queue A dispatch_queue_t object.
 *  @return The initialized instance.
 */
- (instancetype)initWithDispatchQueue:(dispatch_queue_t)queue NS_DESIGNATED_INITIALIZER;

/** Creates a new serial queue with no name. */
- (instancetype)init;

#pragma mark Using queues

/**
 *  Submits a block for asynchronous execution on the queue.
 *
 *  @param block The block to submit.
 *  @see dispatch_async()
 */
- (void)asynchronously:(dispatch_block_t)block;

/**
 *  Submits a block for asynchronous execution on the queue after a delay and time.
 *
 *  @param block The block to submit.
 *  @param time The time to execute the block after.
 *  @param seconds The delay in seconds.
 *  @see dispatch_after()
 */
- (void)execute:(dispatch_block_t)block after:(dispatch_time_t)time withDelay:(NSTimeInterval)seconds;

/**
 *  Submits a block for asynchronous execution on the queue after a delay.
 *
 *  @param block The block to submit.
 *  @param seconds The delay in seconds.
 *  @see dispatch_after()
 */
- (void)execute:(dispatch_block_t)block afterDelay:(NSTimeInterval)seconds;

/**
 *  Submits a block for execution on the queue and waits until it completes.
 *
 *  @param block The block to submit.
 *  @see dispatch_sync()
 */
- (void)synchronously:(dispatch_block_t)block;

/**
 *  Submits a block for execution on the queue multiple times and waits until all executions complete.
 *
 *  @param block The block to submit.
 *  @param iterationCount The number of times to execute the block.
 *  @see dispatch_apply()
 */
- (void)synchronously:(void (^)(size_t))block iterationCount:(size_t)count;

/**
 *  Submits a block for asynchronous execution on the queue and associates it with the group.
 *
 *  @param block The block to submit.
 *  @param inGroup The group to associate the block with.
 *  @see dispatch_group_async()
 */
- (void)asynchronously:(dispatch_block_t)block inGroup:(NSDispatchGroup *)group;

/**
 *  Schedules a block to be submitted to the queue when a group of previously submitted blocks have completed.
 *
 *  @param block The block to submit when the group completes.
 *  @param inGroup The group to observe.
 *  @see dispatch_group_notify()
 */
- (void)notify:(dispatch_block_t)block inGroup:(NSDispatchGroup *)group;

/**
 *  Submits a barrier block for asynchronous execution on the queue.
 *
 *  @param block The barrier block to submit.
 *  @see dispatch_barrier_async()
 */
- (void)barrierAsynchronously:(dispatch_block_t)block;

/**
 *  Submits a barrier block for execution on the queue and waits until it completes.
 *
 *  @param block The barrier block to submit.
 *  @see dispatch_barrier_sync()
 */
- (void)barrierSynchronously:(dispatch_block_t)block;

/**
 *  Suspends execution of blocks on the queue.
 *
 *  @see dispatch_suspend()
 */
- (void)suspend;

/**
 *  Resumes execution of blocks on the queue.
 *
 *  @see dispatch_resume()
 */
- (void)resume;

@end
