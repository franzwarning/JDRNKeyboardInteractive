//
//  KeyboardManager.h
//  InteractiveKeyboard
//
//  Created by Raymond Kennedy on 1/8/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface KeyboardManager : RCTEventEmitter <RCTBridgeModule>

+ (BOOL)keyboardUpdated:(NSNumber *)value;

@end
