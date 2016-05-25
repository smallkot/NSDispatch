//
//  NSDispatchTests.m
//  NSDispatch
//

#import <XCTest/XCTest.h>
#import <dispatch/dispatch.h>
#import <libkern/OSAtomic.h>

#import "NSDispatch.h"

@interface GCDObjCTests : XCTestCase
@end

@implementation GCDObjCTests

- (void)testMainQueue {
  XCTAssertEqual([NSDispatchQueue mainQueue].dispatchQueue, dispatch_get_main_queue());
}

- (void)testGlobalQueues {
  XCTAssertEqual([NSDispatchQueue globalQueue].dispatchQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
  XCTAssertEqual([NSDispatchQueue highPriorityGlobalQueue].dispatchQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0));
  XCTAssertEqual([NSDispatchQueue lowPriorityGlobalQueue].dispatchQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0));
  XCTAssertEqual([NSDispatchQueue backgroundPriorityGlobalQueue].dispatchQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0));
}

- (void)testQueueBlock {
  NSDispatchSemaphore *semaphore = [NSDispatchSemaphore new];
  NSDispatchQueue *queue = [NSDispatchQueue new];
  __block int32_t val = 0;
  
  [queue asynchronously:^{
    OSAtomicIncrement32(&val);
    [semaphore signal];
  }];
  
  [semaphore wait];
  XCTAssertEqual(val, 1);
}

- (void)testQueueBlockAfterDelay {
  NSDispatchSemaphore *semaphore = [NSDispatchSemaphore new];
  NSDispatchQueue *queue = [NSDispatchQueue new];
  NSDate *then = [NSDate new];
  __block int32_t val = 0;
  
  [queue execute:^{
    OSAtomicIncrement32(&val);
    [semaphore signal];
  } afterDelay:0.5];
  
  XCTAssertEqual(val, 0);
  [semaphore wait];
  XCTAssertEqual(val, 1);

  NSDate *now = [NSDate new];
  XCTAssertTrue([now timeIntervalSinceDate:then] > 0.4);
  XCTAssertTrue([now timeIntervalSinceDate:then] < 0.6);
}

- (void)testQueueAndAwaitBlock {
  NSDispatchQueue *queue = [NSDispatchQueue new];
  __block int32_t val = 0;
  
  [queue synchronously:^{ OSAtomicIncrement32(&val); }];
  
  XCTAssertEqual(val, 1);
}

- (void)testQueueAndAwaitBlockIterationCount {
  NSDispatchQueue *queue = [[NSDispatchQueue alloc] initConcurrent];
  __block int32_t val = 0;
  
  [queue synchronously:^(size_t i){ OSAtomicIncrement32(&val); } iterationCount:100];
  
  XCTAssertEqual(val, 100);
}

- (void)testQueueBlockInGroup {
  NSDispatchQueue *queue = [[NSDispatchQueue alloc] initConcurrent];
  NSDispatchGroup *group = [NSDispatchGroup new];
  __block int32_t val = 0;
  
  for (int i = 0; i < 100; ++i) {
    [queue asynchronously:^{ OSAtomicIncrement32(&val); } inGroup:group];
  }
  
  [group wait];
  XCTAssertEqual(val, 100);
}

- (void)testQueueNotifyBlockForGroup {
  NSDispatchQueue *queue = [[NSDispatchQueue alloc] initConcurrent];
  NSDispatchSemaphore *semaphore = [NSDispatchSemaphore new];
  NSDispatchGroup *group = [NSDispatchGroup new];
  __block int32_t val = 0;
  __block int32_t notifyVal = 0;
  
  for (int i = 0; i < 100; ++i) {
    [queue asynchronously:^{ OSAtomicIncrement32(&val); } inGroup:group];
  }
  [queue notify:^{ notifyVal = val; [semaphore signal]; } inGroup:group];

  [semaphore wait];
  XCTAssertEqual(notifyVal, 100);
}

- (void)testQueueBarrierBlock {
  NSDispatchQueue *queue = [[NSDispatchQueue alloc] initConcurrent];
  NSDispatchSemaphore *semaphore = [NSDispatchSemaphore new];
  __block int32_t val = 0;
  __block int32_t barrierVal = 0;

  for (int i = 0; i < 100; ++i) {
    [queue asynchronously:^{ OSAtomicIncrement32(&val); }];
  }
  [queue barrierAsynchronously:^{ barrierVal = val; [semaphore signal]; }];
  for (int i = 0; i < 100; ++i) {
    [queue asynchronously:^{ OSAtomicIncrement32(&val); }];
  }

  [semaphore wait];
  XCTAssertEqual(barrierVal, 100);
}

- (void)testQueueAndAwaitBarrierBlock {
  NSDispatchQueue *queue = [[NSDispatchQueue alloc] initConcurrent];
  __block int32_t val = 0;
  
  for (int i = 0; i < 100; ++i) {
    [queue asynchronously:^{ OSAtomicIncrement32(&val); }];
  }
  [queue barrierSynchronously:^{}];
  XCTAssertEqual(val, 100);
}

static int onceVal;

- (void)onceBlock {
  NSDispatchExecOnce(^{ ++onceVal; });
}

- (void)testExecOnce {
  onceVal = 0;
  for (int i = 0; i < 100; ++i) {
    [self onceBlock];
  }
  
  XCTAssertEqual(onceVal, 1);
}

+ (instancetype)theTestInstance {
  NSDispatchSharedInstance(^{ return [self new]; });
}

- (void)testSharedInstance {
  XCTAssertTrue([[GCDObjCTests theTestInstance] class] == [self class]);
  XCTAssertEqual([GCDObjCTests theTestInstance], [GCDObjCTests theTestInstance]);
}

@end
