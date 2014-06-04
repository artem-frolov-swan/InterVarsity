//
//  AboutViewController.h
//  InterVarsity
//
//  Created by Ben Dennis on 12/10/12.
//  Copyright (c) 2012 My Mobile Fans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController <UIWebViewDelegate>
- (IBAction)back:(id)sender;
- (IBAction)btnBack:(id)sender;
@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) IBOutlet UILabel *textView;

@end
