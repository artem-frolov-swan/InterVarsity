//
//  BacksideViewController.h
//  InterVarsity
//
//  Created by Ben Dennis on 12/8/12.
//  Copyright (c) 2012 My Mobile Fans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TraceViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@protocol BacksideViewDelegate <NSObject>

- (void) backButtonTapped;
- (void) gotoMenuButtonTapped;

@end


@interface BacksideViewController : UIViewController  <UIAlertViewDelegate, UIWebViewDelegate, MFMailComposeViewControllerDelegate> {

    IBOutlet UIView *world1View;
    IBOutlet UIButton *bible;
    UIViewController *frontSide;
    IBOutlet UIImageView *barImage;
    IBOutlet UIScrollView *scrollView1;
    
    IBOutlet NSLayoutConstraint *scrollHeight;
    
    IBOutlet UIButton *shareButton;
    IBOutlet UIButton *prayButton;
    IBOutlet UIButton *menuButton;
    
    IBOutlet UITextView *textView0;
    IBOutlet UITextView *textView1;
    IBOutlet UITextView *textView2;
    IBOutlet UITextView *textView3;
    IBOutlet UITextView *textView4;
    IBOutlet UITextView *textView5;
    IBOutlet UITextView *textView6;
    IBOutlet UITextView *textView7;
    IBOutlet UITextView *textView8;
    
    IBOutlet UIWebView* webView;
    
}
- (IBAction)test:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *showAbout;
@property (strong, nonatomic) id<BacksideViewDelegate> delegate;
- (IBAction)aboutTapped:(id)sender;

@property (nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic,strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) UIViewController *frontSide;
@property (nonatomic, assign) int cardNumber;
@property (nonatomic, strong) IBOutlet UIView *world1View;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView1;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *scrollHeight;
@property (nonatomic,strong)IBOutlet UIButton *bible;

- (void)pray:(int)tag;
- (IBAction)goBack:(id)sender;
- (IBAction)shareApp:(id)sender;
- (IBAction)share:(id)sender;
- (IBAction)goToMenu:(id)sender;
- (IBAction)footerPray:(id)sender;
- (IBAction)startNew:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *share;

@end
