//
//  NSDispatchGroup.h
//  NSDispatch
//

#import <Foundation/Foundation.h>

@interface NSDispatchGroup : NSObject

/** The underlying dispatch group object. */
@property (strong, readonly, nonatomic) dispatch_group_t group;

/**
 *  Initializes a new dispatch group. You may use the +new convenience initializer instead.
 *
 *  @return The initialized instance.
 *  @see dispatch_group_create()
 */
- (instancetype)init;

/**
 *  @param dispatchGroup A dispatch_group_t object.
 *  @return The initialized instance.
 */
- (instancetype)initWithDispatchGroup:(dispatch_group_t)group NS_DESIGNATED_INITIALIZER;

/**
 *  Explicitly indicates that a block has entered the group.
 *
 *  @see dispatch_group_enter()
 */
- (void)enter;

/**
 *  Explicitly indicates that a block in the group has completed.
 *
 *  @see dispatch_group_leave()
 */
- (void)leave;

/**
 *  Waits forever for the previously submitted blocks in the group to complete.
 *
 *  @return 0 if all blocks completed, or a non-zero value if the timeout occurred.
 *  @see dispatch_group_wait()
 */
- (NSInteger)wait;

/**
 *  Waits for the previously submitted blocks in the group to complete.
 *
 *  @param seconds The time to wait in seconds.
 *  @return 0 if all blocks completed, or a non-zero value if the timeout occurred.
 *  @see dispatch_group_wait()
 */
- (NSInteger)wait:(NSTimeInterval)seconds;

@end
