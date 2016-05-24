//
//  NSDispatchGroup.m
//  NSDispatch
//

#import "NSDispatchGroup.h"

@interface NSDispatchGroup ()
@property (strong, readwrite, nonatomic) dispatch_group_t group;
@end

@implementation NSDispatchGroup

#pragma mark Lifecycle

- (instancetype)init {
    return [self initWithDispatchGroup:dispatch_group_create()];
}

- (instancetype)initWithDispatchGroup:(dispatch_group_t)group {
    self = [super init];
    if (self) {
        self.group = group;
    }
    
    return self;
}

#pragma mark Public methods

- (void)enter {
    dispatch_group_enter(self.group);
}

- (void)leave {
    dispatch_group_leave(self.group);
}

- (void)wait {
    dispatch_group_wait(self.group, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(double)seconds {
    return dispatch_group_wait(self.group, dispatch_time(DISPATCH_TIME_NOW, (seconds * NSEC_PER_SEC))) == 0;
}

@end
