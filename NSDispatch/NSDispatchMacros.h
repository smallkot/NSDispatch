//
//  NSDispatchMacros.h
//  NSDispatch
//

/**
 *  Inserts code that executes a block only once, regardless of how many times the macro is invoked.
 *
 *  @param block The block to execute once.
 */
#ifndef NSDispatchExecOnce
#define NSDispatchExecOnce(block) \
{ \
  static dispatch_once_t predicate = 0; \
  dispatch_once(&predicate, block); \
}
#endif

/**
 *  Inserts code that declares, creates, and returns a single instance, regardless of how many times the macro is invoked.
 *
 *  @param block A block that creates and returns the instance value.
 */
#ifndef NSDispatchSharedInstance
#define NSDispatchSharedInstance(block) \
{ \
  static dispatch_once_t predicate = 0; \
  static id sharedInstance = nil; \
  dispatch_once(&predicate, ^{ sharedInstance = block(); }); \
  return sharedInstance; \
}
#endif
