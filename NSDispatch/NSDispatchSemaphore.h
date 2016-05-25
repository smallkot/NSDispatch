//
//  NSDispatchSemaphore.h
//  NSDispatch
//

#import <Foundation/Foundation.h>

@interface NSDispatchSemaphore : NSObject

/**
 *  The underlying dispatch semaphore object.
 *
 *  @return The dispatch semaphore object.
 */
@property (strong, readonly, nonatomic) dispatch_semaphore_t semaphore;

/**
 *  Initializes a new semaphore with starting value 0.
 *  @see dispatch_semaphore_create()
 */
- (instancetype)init;

/**
 *  Initializes a new semaphore with a given value.
 *
 *  @param value The starting value for the semaphore.
 *  @see dispatch_semaphore_create()
 */
- (instancetype)initWithValue:(long)value;

/**
 *  Initializes a new semaphore with a given dispatch_semaphore_t.
 *  @param dispatchSemaphore A dispatch_semaphore_t object.
 *  @see dispatch_semaphore_create()
 */
- (instancetype)initWithDispatchSemaphore:(dispatch_semaphore_t)dispatchSemaphore NS_DESIGNATED_INITIALIZER;

/**
 *  Signals (increments) the semaphore.
 *
 *  @return Non-zero if a thread is woken.
 *  @see dispatch_semaphore_signal()
 */
- (NSInteger)signal;

/**
 *  Waits forever for the semaphore.
 *
 *  @return 0 on success, or non-zero if the timeout occurred.
 *  @see dispatch_semaphore_wait()
 */
- (NSInteger)wait;

/**
 *  Waits for (decrements) the semaphore.
 *
 *  @param seconds The time to wait in seconds.
 *  @return 0 on success, or non-zero if the timeout occurred.
 *  @see dispatch_semaphore_wait()
 */
- (NSInteger)wait:(double)seconds;

@end