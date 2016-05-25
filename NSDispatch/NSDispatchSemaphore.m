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
    self = [super init];
    if (self) {
        self.semaphore = semaphore;
    }
    
    return self;
}

#pragma mark Public methods.

- (NSInteger)signal {
    return dispatch_semaphore_signal(self.semaphore);
}

- (NSInteger)wait {
    return dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
}

- (NSInteger)wait:(NSTimeInterval)seconds {
    return dispatch_semaphore_wait(self.semaphore, dispatch_time(DISPATCH_TIME_NOW, (seconds * NSEC_PER_SEC)));
}

@end
