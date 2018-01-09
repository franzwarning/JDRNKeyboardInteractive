//
//  KeyboardManager.m
//  InteractiveKeyboard
//
//  Created by Raymond Kennedy on 1/8/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "KeyboardManager.h"

NSString *const kKeyboardUpdated = @"KeyboardUpdated";

@implementation KeyboardManager
{
  bool hasListeners;
}

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
  return @[kKeyboardUpdated];
}

- (void)startObserving {
  for (NSString *event in [self supportedEvents]) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:event
                                               object:nil];
  }
}

- (void)stopObserving {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

# pragma mark Public

+ (BOOL)keyboardUpdated:(NSNumber *)value {
  [self postNotificationName:kKeyboardUpdated withPayload:value];
  return YES;
}

# pragma mark Private

+ (void)postNotificationName:(NSString *)name withPayload:(NSObject *)object {
  NSDictionary<NSString *, id> *payload = @{@"payload": object};
  [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                      object:self
                                                    userInfo:payload];
}

- (void)handleNotification:(NSNotification *)notification {
  [self sendEventWithName:notification.name body:notification.userInfo];
}

@end
