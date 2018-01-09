//
//  JDViewController.m
//  InteractiveKeyboard
//
//  Created by Raymond Kennedy on 1/8/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "JDViewController.h"
#import "NgKeyboardTracker.h"
#import "KeyboardManager.h"

@interface JDViewController () <NgKeyboardTrackerDelegate>
@property (nonatomic, strong, readonly) NgPseudoInputAccessoryViewCoordinator *coordinator;
@property (nonatomic, strong) NSDictionary *launchOptions;
@end

@implementation JDViewController

- (instancetype)initWithLaunchOptions:(NSDictionary *)launchOptions {
  
  if ((self = [super init])) {
    self.launchOptions = launchOptions;
  }
  
  return self;
}

- (void)loadView {
  [super loadView];
  NSURL *jsCodeLocation;
  
  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
  
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"InteractiveKeyboard"
                                               initialProperties:nil
                                                   launchOptions:[NSMutableDictionary dictionary]];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  self.view = rootView;
  
  _coordinator = [[NgKeyboardTracker sharedTracker] createPseudoInputAccessoryViewCoordinator];
  [_coordinator setPseudoInputAccessoryViewHeight:0];
}

- (UIView *)inputAccessoryView {
  return _coordinator.pseudoInputAccessoryView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [[NgKeyboardTracker sharedTracker] addDelegate:self];
}

- (void)dealloc {
  [[NgKeyboardTracker sharedTracker] removeDelegate:self];
}

- (void)notifyYValue:(NgKeyboardTracker *)tracker {
  CGRect kbframe = [[NgKeyboardTracker sharedTracker] keyboardCurrentFrameForView:self.view];
  NSLog(@"Appearence state: %@", NgAppearanceStateAsString([tracker appearanceState]));
  NSLog(@"Keyboard Y value: %f", kbframe.origin.y);
  [KeyboardManager keyboardUpdated:[NSNumber numberWithDouble:kbframe.origin.y]];
}

- (void)keyboardTrackerDidUpdate:(NgKeyboardTracker *)tracker {
  [self notifyYValue:tracker];
}
- (void)keyboardTrackerDidChangeAppearanceState:(NgKeyboardTracker *)tracker {
  [self notifyYValue:tracker];
}

@end
