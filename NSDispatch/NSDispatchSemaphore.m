//
//  NSDispatchSemaphore.m
//  NSDispatch
//

#import "NSDispatchSemaphore.h"

@interface NSDispatchSemaphore ()
@property (strong, readwrite, nonatomic) dispatch_semaphore_t semaphore;
@end

@implementation NSDispatchSemaphore

#pragma mark Lifecycle.

- (instancetype)init {
    return [self initWithValue:0];
}

- (instancetype)initWithValue:(long)value {
    return [self initWithDispatchSemaphore:dispatch_semaphore_create(value)];
}

- (instancetype)initWithDispatchSemaphore:(dispatch_semaphore_t)semaphore {
    if ((self = [super init]) != nil) {
        self.semaphore = semaphore;
    }
    
    return self;
}

#pragma mark Public methods.

- (BOOL)signal {
    return dispatch_semaphore_signal(self.semaphore) != 0;
}

- (void)wait {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(double)seconds {
    return dispatch_semaphore_wait(self.semaphore, dispatch_time(DISPATCH_TIME_NOW, (seconds * NSEC_PER_SEC))) == 0;
}

@end
