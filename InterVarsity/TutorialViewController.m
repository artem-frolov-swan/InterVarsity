//
//  TutorialViewController.m
//  InterVarsity
//
//  Created by Rahul on 13/12/13.
//  Copyright (c) 2013 My Mobile Fans. All rights reserved.
//

#import "TutorialViewController.h"
#import "AppDelegate.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"--------------------------TutorialView--------------------------");
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
    {
        
        float titleHeight = self.view.frame.size.width * (67.5/320.0);
        float fScrollHeight = self.view.frame.size.height;
        
    UIImageView *bar1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, titleHeight)];
    bar1.image = [UIImage imageNamed:@"bar1-iPhone@2x.png"];
    [self.view addSubview:bar1];
        
        
    bool iPhone5 = NO;
    int offsetY = 0;
    int offsetHeight = [UIScreen mainScreen].bounds.size.width * (480.0/320.0);
    NSString *card = @"card1Image.png";
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    if(screenHeight >= 568.0) {
        iPhone5 = YES;
        offsetY = 0;
        offsetHeight = [UIScreen mainScreen].bounds.size.width * (566.0/320.0);
        card = @"card1ImageLong.png";
    }
        
    UIImageView *card1Pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, offsetY,  self.view.frame.size.width, offsetHeight)];
    card1Pic.image = [UIImage imageNamed:card];
    [self.view addSubview:card1Pic];
        
        //Setup Buttons
        save1 = [UIButton buttonWithType:UIButtonTypeCustom];
        save1.frame = CGRectMake(172, fScrollHeight-66, 61, 61);
        [save1 setImage:[UIImage imageNamed:@"new_blue_save.png"] forState:UIControlStateNormal];
        //[save1 addTarget:self action:@selector(lockOrUnlockCurrentCard:) forControlEvents:UIControlEventTouchUpInside];
        [save1 setEnabled: NO];
        [self.view addSubview:save1];
        
        
        menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.frame = CGRectMake(11, fScrollHeight-66, 61, 61);
        [menuButton setImage:[UIImage imageNamed:@"new_blue_menu.png"] forState:UIControlStateNormal];
       // [menuButton addTarget:self action:@selector(goToMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:menuButton];
        [menuButton setEnabled: NO];
        eraseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        eraseButton.frame = CGRectMake(90, fScrollHeight-66, 61, 61);
        [eraseButton setImage:[UIImage imageNamed:@"new_blue_erase.png"] forState:UIControlStateNormal];
        // [eraseButton addTarget:self action:@selector(deleteTapper:) forControlEvents:UIControlEventTouchUpInside];
        [eraseButton setEnabled:NO];
        [self.view addSubview:eraseButton];
        
        infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        infoButton.frame = CGRectMake(250, fScrollHeight-66, 61, 61);
        //make sure this works below
        //infoButton.tag = page +1;
        [infoButton setEnabled: NO];
        [infoButton setImage:[UIImage imageNamed:@"new_blue_info.png"] forState:UIControlStateNormal];
        //[infoButton addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:infoButton];
        // Do any additional setup after loading the view.
        
        float fCloseBtnWidth = 22;
        float fCloseBtnHeight = 22;
        float fXPos = (bar1.frame.size.width - fCloseBtnWidth) - 10;
        float fYPos = (bar1.frame.size.height - fCloseBtnHeight) - 10;
        UIImageView *btnClose = [[UIImageView alloc] initWithFrame:CGRectMake(fXPos, fYPos, fCloseBtnWidth, fCloseBtnHeight)];
        btnClose.image = [UIImage imageNamed:@"btntutorialcloseiphone.png"];
        [self.view addSubview:btnClose];
    }
    else
    {
        float fScrollWidth = 1024;
        float fScrollHeight = fScrollWidth * (768.0/1024.0);
        float titleHeight = fScrollWidth * (150.0/2048.0);
        
        UIImageView *bar1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar1.image = [UIImage imageNamed:@"bar1-iPad@4x.png"];
        [self.view insertSubview:bar1 atIndex:1];
        
        float fCloseBtnWidth = 44;
        float fCloseBtnHeight = 44;
        float fXPos = (bar1.frame.size.width - fCloseBtnWidth) - 7;
        float fYPos = (bar1.frame.size.height - fCloseBtnHeight) - 10;
        UIImageView *btnClose = [[UIImageView alloc] initWithFrame:CGRectMake(fXPos, fYPos, fCloseBtnWidth, fCloseBtnHeight)];
        btnClose.image = [UIImage imageNamed:@"new_ipad_close@4x.png"];
        [self.view addSubview:btnClose];
    }
}



//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"--------------------------HandSingleTap--------------------------");

    NSLog(@"Disolve here");
    
    NSLog(@"Disolve hereeeee");
    [UIView animateWithDuration: 1.0
                     animations:^{
                         self.view.alpha = 0.65;
                     }
                     completion:^(BOOL finished) {
                         
//                         AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//                         
//                         if (appDelegate.bResumeCard == NO)
//                         {
//                             [appDelegate resumeCard:nil];
//                         }
//                         else
//                         {
//                             [appDelegate resumeCard:self];
//                             appDelegate.bResumeCard = NO;
//                         }
                         [self.navigationController popViewControllerAnimated:YES];
                     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
