//
//  AppDelegate.h
//  InterVarsity
//
//  Created by Ben Dennis on 11/29/12.
//  Copyright (c) 2012 My Mobile Fans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController* mainViewController;
@property (readwrite, assign) BOOL bResumeCard;

- (void) startNewCard;
-(IBAction)resumeCard:(id)sender;

@end
