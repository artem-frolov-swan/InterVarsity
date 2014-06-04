//
//  ViewController.h
//  InterVarsity
//
//  Created by Ben Dennis on 11/29/12.
//  Copyright (c) 2012 My Mobile Fans. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface ViewController : UIViewController <UIActionSheetDelegate> {
    IBOutlet UILabel *newLabel;
    IBOutlet UILabel *worldLabel;
}
- (IBAction)shareApp:(id)sender;
- (IBAction)iPadStartNew:(id)sender;
-(IBAction)resumeiPadSession:(id)sender;

-(IBAction)btnTutorialClick:(id)sender;

@property (strong, nonatomic) UIPopoverController *popoverController;

@end
