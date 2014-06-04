//
//  TraceViewController.m
//  InterVarsity
//
//  Created by Ben Dennis on 11/29/12.
//  Copyright (c) 2012 My Mobile Fans. All rights reserved.
//

#import "TraceViewController.h"
#import "DrawableView.h"
#import "BacksideViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"


@interface TraceViewController ()

@end

@implementation TraceViewController

@synthesize currentCard, locked, frontSide, backside;
@synthesize bResume;
@synthesize noOverlay;

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.noOverlay = NO;
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
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    BOOL bOpenedOnce = [[userdefault objectForKey:@"appstartedatleastonce"] boolValue];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminate:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:app];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *keyString = [NSString stringWithFormat:@"savedCard%d",1];
    NSString *imageString = [NSString stringWithFormat:@"/card%d.png", 1];
    
    NSLog(@"Contents of file: %@ ", [[NSUserDefaults standardUserDefaults] objectForKey:keyString]);
    pageControl.numberOfPages = 7;
    int page = 0;
    
    sidePanelIsVisibile = NO;
    BOOL bCardOnResume = NO;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        float fScrollWidth = 1024;
        float fScrollHeight = fScrollWidth * (768.0/1024.0);
        float titleHeight = fScrollWidth * (150.0/2048.0);
        //scrollView.frame = CGRectMake(0, 0, 1024, 768);
        //scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(19,20,984,708)];
        //scrollView.contentSize = CGSizeMake(6888, 708);
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        scrollView.scrollEnabled = NO;
        scrollView.pagingEnabled = YES;
        locked = YES;
        
        
        
        //  UIImage *cardBackImage = [UIImage imageNamed:@"cardFront@2x.png"];
        
        //UIImageView *cardBack1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 300,431)];
        //cardBack1.image = cardBackImage;
        
        //  UIImageView *cardBack2 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 300,431)];
        // cardBack2.image = cardBackImage;
        
        //Setup First Card
        float fXOffset = 0;
        fOverlayBarHeight = 37;
        card1 = [[DrawableView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth,708) andCardNumber:1];
        
        UIImageView *bar1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar1.image = [UIImage imageNamed:@"bar2-iPad@4x.png"];
        UIImageView *card1Pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, fScrollHeight)];
        card1Pic.image = [UIImage imageNamed:@"CardFront2-iPad@2x.png"];
        // [card1 addSubview:cardBack1];
        [card1 addSubview:bar1];
        [card1 addSubview:card1Pic];
        
        [card1 touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card1];
        
        
        
        fXPosOverLay = card1Pic.frame.origin.x;
        fYPosOverLay = card1Pic.frame.origin.y;
        fOverLayWidth = card1Pic.frame.size.width;
        fOverLayHeight = card1Pic.frame.size.height;

        
        
        //Setup Second Card
        fXOffset = fXOffset+card1.frame.size.width;
        card2 = [[DrawableView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth,708) andCardNumber:2];
        
        UIImageView *bar2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar2.image = [UIImage imageNamed:@"bar3-iPad@4x.png"];
        UIImageView *card2Pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, fScrollHeight)];
        card2Pic.image = [UIImage imageNamed:@"CardFront3-iPad@2x.png"];
        // [card1 addSubview:cardBack1];
        [card2 addSubview:bar2];
        [card2 addSubview:card2Pic];
        
        [card2 touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card2];
        
        //Setup Third Card
        fXOffset = fXOffset+card2.frame.size.width;
        card3 = [[DrawableView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth,708) andCardNumber:3];
        
        UIImageView *bar3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar3.image = [UIImage imageNamed:@"bar4-iPad@4x.png"];
        UIImageView *card3Pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, fScrollHeight)];
        card3Pic.image = [UIImage imageNamed:@"CardFront4-iPad@2x.png"];
        // [card1 addSubview:cardBack1];
        [card3 addSubview:bar3];
        [card3 addSubview:card3Pic];
        
        [card3 touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card3];
        
        //Setup Fourth Card
        fXOffset = fXOffset+card3.frame.size.width;
        card4 = [[DrawableView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth,708) andCardNumber:4];
        
        UIImageView *bar4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar4.image = [UIImage imageNamed:@"bar5-iPad@4x.png"];
        UIImageView *card4Pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, fScrollHeight)];
        card4Pic.image = [UIImage imageNamed:@"CardFront5-iPad@2x.png"];
        // [card1 addSubview:cardBack1];
        [card4 addSubview:bar4];
        [card4 addSubview:card4Pic];
        
        [card4 touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card4];
        
        
        //Setup Fourth Card
        fXOffset = fXOffset+card4.frame.size.width;
        card5 = [[DrawableView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth,708) andCardNumber:5];
        
        UIImageView *bar5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar5.image = [UIImage imageNamed:@"bar6-iPad@4x.png"];
        UIImageView *card5Pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, fScrollHeight)];
        card5Pic.image = [UIImage imageNamed:@"CardFront6-iPad@2x.png"];
        // [card1 addSubview:cardBack1];
        [card5 addSubview:bar5];
        [card5 addSubview:card5Pic];
        
        [card5 touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card5];
        
        //Setup Fourth Card
        fXOffset = fXOffset+card5.frame.size.width;
        card6 = [[DrawableView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth,708) andCardNumber:6];
        
        UIImageView *bar6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar6.image = [UIImage imageNamed:@"bar7-iPad@4x.png"];
        UIImageView *card6Pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, fScrollHeight)];
        card6Pic.image = [UIImage imageNamed:@"CardFront7-iPad@2x.png"];
        // [card1 addSubview:cardBack1];
        [card6 addSubview:bar6];
        [card6 addSubview:card6Pic];
        
        [card6 touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card6];
        
        
        //Setup Fifth Card
        float fOffset = 100;
        fXOffset = fXOffset+card6.frame.size.width + fOffset;
        card8 = [[UIView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth,fScrollHeight)];
        
        UIImageView *bar8 = [[UIImageView alloc] initWithFrame:CGRectMake(0 - fOffset, 0, fScrollWidth + (fOffset/2), titleHeight)];
        bar8.image = [UIImage imageNamed:@"bar8-iPad@4x.png"];
        
        
        fXOffset = fXOffset+fScrollWidth;
        scrollView.contentSize = CGSizeMake(fXOffset - 100, 708);
        
        
        UIImage* imageRound = [UIImage imageNamed:@"roundbgiPad.png"];
        
        //set up button1
        UIButton *world1 = [UIButton buttonWithType:UIButtonTypeCustom];
        world1.frame = CGRectMake(90,70, 300, 300);
        world1.tag = 7;
        [world1 setImage:[UIImage imageNamed:@"new_world1.png"] forState:UIControlStateNormal];
        [world1 addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        //set up button2
        UIButton *world2 = [UIButton buttonWithType:UIButtonTypeCustom];
        world2.tag = 8;
        world2.frame = CGRectMake(410,70, 300, 300);
        [world2 setImage:[UIImage imageNamed:@"new_world2.png"] forState:UIControlStateNormal];
        [world2 addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
                //set up button3
        UIButton *world3 = [UIButton buttonWithType:UIButtonTypeCustom];
        world3.tag = 9;
        world3.frame = CGRectMake(410,350, 300, 300);
        [world3 setImage:[UIImage imageNamed:@"new_world3.png"] forState:UIControlStateNormal];
        [world3 addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
        
        //set up button4
        UIButton *world4 = [UIButton buttonWithType:UIButtonTypeCustom];
        world4.tag = 10;
        world4.frame = CGRectMake(90,350, 300, 300);
        [world4 setImage:[UIImage imageNamed:@"new_world4.png"] forState:UIControlStateNormal];
        [world4 addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"contentOffset"]) {
            //reload the last position
            double offset = [[NSUserDefaults standardUserDefaults] doubleForKey:@"contentOffset"];
            scrollView.contentOffset = CGPointMake(offset, 0);
            //update page control
            CGFloat pageWidth = fScrollWidth;
            int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
            pageControl.currentPage=page;
            
            [save1 setEnabled:YES];
            
            c1HasBeenLocked = [[NSUserDefaults standardUserDefaults] boolForKey:@"c1HasBeenLocked"];
            c2HasBeenLocked = [[NSUserDefaults standardUserDefaults] boolForKey:@"c2HasBeenLocked"];
            c3HasBeenLocked = [[NSUserDefaults standardUserDefaults] boolForKey:@"c3HasBeenLocked"];
            c4HasBeenLocked = [[NSUserDefaults standardUserDefaults] boolForKey:@"c4HasBeenLocked"];
            
            cardLockedOnResume = [[NSUserDefaults standardUserDefaults] boolForKey:@"cardLockedOnResume"];
            
            if (cardLockedOnResume) {
                bCardOnResume = YES;
                [self lockOrUnlockCurrentCard:save1];
            }
            
            [self scrollViewDidEndDecelerating:scrollView];
            
            
            /* //this code replaced by calling didEndDecelerating on the scrollView
             if (page < 4)
             [eraseButton setEnabled:YES];
             [save1 setEnabled:YES];
             if (page < 4)
             [self checkLockOrUnlockAfterReset];
             if (page == 4) {
             [self lockOrUnlockCurrentCard:save1];
             [eraseButton setEnabled:NO];
             [save1 setEnabled:NO];
             }
             */
        }
        
        NSNumber *tag = [NSNumber numberWithInt:pageControl.currentPage +1];
        [self performSelectorOnMainThread:@selector(populateSidePanelContentForTag:) withObject:tag waitUntilDone:NO];
        
        [card8 addSubview:bar8];
        [card8 addSubview:world1];
        [card8 addSubview:world2];
        [card8 addSubview:world3];
        [card8 addSubview:world4];
        [card8 touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card8];
        
                
    } else {
        /* Device is an iPhone*/
        
        BOOL iPhone5 = NO;
        float aspect = 480.0/320.0;
        if([UIScreen mainScreen].bounds.size.height >= 568) {
            iPhone5 = YES;
            aspect = 568.0/320.0;
        }
        
        float fScrollWidth = self.view.frame.size.width;
        float fScrollHeight = self.view.frame.size.width * aspect;
        float titleHeight = fScrollWidth * (67.5/320.0);
        float fXOffset = 0;
        float yOffset = 0;
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,fScrollWidth, fScrollHeight)];
        //scrollView.contentSize = CGSizeMake(1500, 431);
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        scrollView.scrollEnabled = NO;
        scrollView.pagingEnabled = YES;
        locked = YES;
        
        UIImage *cardBackImage = [UIImage imageNamed:@"cardstartedinner_iphone.png"];
        
        UIImageView *cardBack1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, fScrollWidth, fScrollHeight)];
        cardBack1.image = cardBackImage;
        
        UIImageView *cardBack2 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, fScrollWidth, fScrollHeight)];
        cardBack2.image = cardBackImage;
        
        //Setup First Card
        fXOffset = 0;
        card1 = [[DrawableView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth, fScrollHeight) andCardNumber:1];
        
        fOverlayBarHeight = 37;
        UIImageView *bar1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar1.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        bar1.image = [UIImage imageNamed:@"bar2-iPhone@2x.png"];
        
        if(iPhone5)
            yOffset = 0;
        else
            yOffset = 0;
        
        UIImageView *card1Pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, yOffset, fScrollWidth, fScrollHeight)];
        if(iPhone5)
            card1Pic.image = [UIImage imageNamed:@"card2ImageLong.png"];
        else
            card1Pic.image = [UIImage imageNamed:@"card2Image.png"];
        [card1 addSubview:cardBack1];
        [card1 addSubview:bar1];
        [card1 addSubview:card1Pic];
        
        [card1 touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card1];
        
        fXPosOverLay = card1Pic.frame.origin.x;
        fYPosOverLay = card1Pic.frame.origin.y;
        fOverLayWidth = card1Pic.frame.size.width;
        fOverLayHeight = card1Pic.frame.size.height;
        
        //
        
        //Setup Second Card
        fXOffset = fXOffset + card1.frame.size.width;
        card2 = [[DrawableView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth, fScrollHeight) andCardNumber:2];
        
        UIImageView *bar2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar2.image = [UIImage imageNamed:@"bar3-iPhone@2x.png"];
        
        UIImageView *card2Pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, yOffset, fScrollWidth, fScrollHeight)];
        if(iPhone5)
            card2Pic.image = [UIImage imageNamed:@"card3ImageLong.png"];
        else
            card2Pic.image = [UIImage imageNamed:@"card3Image.png"];
        [card2 addSubview:cardBack2];
        [card2 addSubview:card2Pic];
        [card2 addSubview:bar2];
        [card2 touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card2];
        
        
        //Setup Third Card
        fXOffset = fXOffset + card2.frame.size.width;
        card3 = [[DrawableView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth, fScrollHeight) andCardNumber:3];
        UIImageView *bar3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar3.image = [UIImage imageNamed:@"bar4-iPhone@2x.png"];
        
        UIImageView *card3Pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, yOffset, fScrollWidth, fScrollHeight)];
        if(iPhone5)
            card3Pic.image = [UIImage imageNamed:@"card4ImageLong.png"];
        else
            card3Pic.image = [UIImage imageNamed:@"card4Image.png"];
        UIImageView *cardBack3 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, fScrollWidth, fScrollHeight)];
        cardBack3.image = cardBackImage;
        [card3 addSubview:cardBack3];
        [card3 addSubview:card3Pic];
        [card3 addSubview:bar3];
        [card3 touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card3];
        
        //Setup Fourth Card
        fXOffset = fXOffset + card3.frame.size.width;
        card4 = [[DrawableView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth, fScrollHeight) andCardNumber:4];
        
        UIImageView *bar4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar4.image = [UIImage imageNamed:@"bar5-iPhone@2x.png"];
        
        
        UIImageView *card4Pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, yOffset, fScrollWidth, fScrollHeight)];
        if(iPhone5)
            card4Pic.image = [UIImage imageNamed:@"card5ImageLong.png"];
        else
            card4Pic.image = [UIImage imageNamed:@"card5Image.png"];
        
        UIImageView *cardBack4 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, fScrollWidth, fScrollHeight)];
        cardBack4.image = cardBackImage;
        [card4 addSubview:cardBack4];
        [card4  addSubview:card4Pic];
        [card4 addSubview:bar4];
        [card4  touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card4];
        
        
        //Setup Fourth Card
        fXOffset = fXOffset + card4.frame.size.width;
        card5 = [[DrawableView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth, fScrollHeight) andCardNumber:5];
        
        UIImageView *bar5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar5.image = [UIImage imageNamed:@"bar6-iPhone@2x.png"];
        
        
        UIImageView *card5Pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, yOffset, fScrollWidth, fScrollHeight)];
        if(iPhone5)
            card5Pic.image = [UIImage imageNamed:@"card6ImageLong.png"];
        else
            card5Pic.image = [UIImage imageNamed:@"card6Image.png"];
        UIImageView *cardBack5 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, fScrollWidth, fScrollHeight)];
        cardBack5.image = cardBackImage;
        [card5 addSubview:cardBack5];
        [card5  addSubview:card5Pic];
        [card5 addSubview:bar5];
        [card5  touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card5];
        
        
        //Setup sixth Card
        fXOffset = fXOffset + card5.frame.size.width;
        card6 = [[DrawableView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth, fScrollHeight) andCardNumber:6];
        
        UIImageView *bar6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar6.image = [UIImage imageNamed:@"bar7-iPhone@2x.png"];
        
        
        UIImageView *card6Pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, yOffset, fScrollWidth, fScrollHeight)];
        if(iPhone5)
            card6Pic.image = [UIImage imageNamed:@"card7ImageLong.png"];
        else
            card6Pic.image = [UIImage imageNamed:@"card7Image.png"];
        UIImageView *cardBack6 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, fScrollWidth, fScrollHeight)];
        cardBack6.image = cardBackImage;
        [card6 addSubview:cardBack6];
        [card6  addSubview:card6Pic];
        [card6 addSubview:bar6];
        [card6  touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card6];
        
        
        //Setup Fifth Card
        fXOffset = fXOffset + card6.frame.size.width;
        card8 = [[UIView alloc] initWithFrame:CGRectMake(fXOffset,0,fScrollWidth, fScrollHeight)];
        UIImageView *bar8 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScrollWidth, titleHeight)];
        bar8.image = [UIImage imageNamed:@"bar8-iPhone.png"];
        
        
        
        UIImageView *cardBack8 = [[UIImageView alloc] initWithFrame:CGRectMake(0,yOffset, fScrollWidth, fScrollHeight)];
        cardBack8.image = cardBackImage;
        
        
        UIImage* imageRound = [UIImage imageNamed:@"roundbgiphone.png"];
        
        float w = scrollView.frame.size.width/2;
        float h = scrollView.frame.size.height/2;
        
        //set up button1
        UIButton *world1 = [UIButton buttonWithType:UIButtonTypeCustom];
        world1.frame = CGRectMake(w-140, h-165, 133, 125);
        world1.tag = 7;
        [world1 setImage:[UIImage imageNamed:@"world1@2x.png"] forState:UIControlStateNormal];
        [world1 addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* lblBg1 = [UIButton buttonWithType:UIButtonTypeCustom];
        lblBg1.tag = 7;
        lblBg1.frame = CGRectMake(11, world1.frame.origin.y + world1.frame.size.height + 1, 22, 22);
        [lblBg1 setBackgroundImage:imageRound forState:UIControlStateNormal];
        [lblBg1 addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
        //UIImageView* lblBg1 = [[UIImageView alloc] initWithFrame:CGRectMake(11, world1.frame.origin.y + world1.frame.size.height + 1, 22, 22)];
        //lblBg1.backgroundColor = [UIColor colorWithPatternImage:imageRound];
        lblBg1.center = CGPointMake(world1.center.x, lblBg1.center.y);
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        label1.textAlignment = UITextAlignmentCenter;
        label1.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        label1.text = @"1";
        label1.font = [UIFont fontWithName:@"Futura" size:14];
        label1.backgroundColor = [UIColor clearColor];
        [lblBg1 addSubview:label1];
        
        float offsetRowY = 25;
        if(iPhone5) {
            offsetRowY = 40;
        }
        
        
        fXOffset = fXOffset + card8.frame.size.width;
        scrollView.contentSize = CGSizeMake(fXOffset, 431);
        
        //set up button2
        UIButton *world2 = [UIButton buttonWithType:UIButtonTypeCustom];
        world2.tag = 8;
        world2.frame = CGRectMake(w+7, h-165, 133, 125);
        [world2 setImage:[UIImage imageNamed:@"world2@2x.png"] forState:UIControlStateNormal];
        [world2 addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton* lblBg2 = [UIButton buttonWithType:UIButtonTypeCustom];
        lblBg2.tag = 8;
        lblBg2.frame = CGRectMake(155, world2.frame.origin.y + world2.frame.size.height + 1, 22, 22);
        [lblBg2 setBackgroundImage:imageRound forState:UIControlStateNormal];
        [lblBg2 addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
        //UIImageView* lblBg2 = [[UIImageView alloc] initWithFrame:CGRectMake(155, world2.frame.origin.y + world2.frame.size.height + 1, 22, 22)];
        //lblBg2.backgroundColor = [UIColor colorWithPatternImage:imageRound];
        lblBg2.center = CGPointMake(world2.center.x, lblBg2.center.y);
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        label2.textAlignment = UITextAlignmentCenter;
        label2.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        label2.text = @"2";
        label2.font = [UIFont fontWithName:@"Futura" size:14];
        label2.backgroundColor = [UIColor clearColor];
        [lblBg2 addSubview:label2];
        
        //set up button3
        UIButton *world3 = [UIButton buttonWithType:UIButtonTypeCustom];
        world3.tag = 9;
        world3.frame = CGRectMake(w+7, h+offsetRowY, 133, 125);
        [world3 setImage:[UIImage imageNamed:@"world3@2x.png"] forState:UIControlStateNormal];
        [world3 addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
       
        UIButton* lblBg3 = [UIButton buttonWithType:UIButtonTypeCustom];
        lblBg3.tag = 9;
        lblBg3.frame = CGRectMake(155, world3.frame.origin.y + world3.frame.size.height + 1, 22, 22);
        [lblBg3 setBackgroundImage:imageRound forState:UIControlStateNormal];
        [lblBg3 addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
        //UIImageView* lblBg3 = [[UIImageView alloc] initWithFrame:CGRectMake(155, world3.frame.origin.y + world3.frame.size.height + 1, 22, 22)];
        //lblBg3.backgroundColor = [UIColor colorWithPatternImage:imageRound];
        lblBg3.center = CGPointMake(world3.center.x, lblBg3.center.y);
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        label3.textAlignment = UITextAlignmentCenter;
        label3.backgroundColor = [UIColor clearColor];
        label3.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        label3.text = @"3";
        label3.font = [UIFont fontWithName:@"Futura" size:14];
        label3.backgroundColor = [UIColor clearColor];
        [lblBg3 addSubview:label3];
        
        //set up button4
        UIButton *world4 = [UIButton buttonWithType:UIButtonTypeCustom];
        world4.tag = 10;
        world4.frame = CGRectMake(w-140, h+offsetRowY, 133, 125);
        [world4 setImage:[UIImage imageNamed:@"world4@2x.png"] forState:UIControlStateNormal];
        [world4 addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* lblBg4 = [UIButton buttonWithType:UIButtonTypeCustom];
        lblBg4.tag = 10;
        lblBg4.frame = CGRectMake(11, world4.frame.origin.y + world4.frame.size.height + 1, 22, 22);
        [lblBg4 setBackgroundImage:imageRound forState:UIControlStateNormal];
        [lblBg4 addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
        //UIImageView* lblBg4 = [[UIImageView alloc] initWithFrame:CGRectMake(11, world4.frame.origin.y + world4.frame.size.height + 1, 22, 22)];
        //lblBg4.backgroundColor = [UIColor colorWithPatternImage:imageRound];
        lblBg4.center = CGPointMake(world4.center.x, lblBg4.center.y);
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        label4.textAlignment = UITextAlignmentCenter;
        label4.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        label4.text = @"4";
        label4.font = [UIFont fontWithName:@"Futura" size:14];
        label4.backgroundColor = [UIColor clearColor];
        [lblBg4 addSubview:label4];
        
        [card8 addSubview:cardBack5];
        [card8 addSubview:lblBg1];
        [card8 addSubview:lblBg2];
        [card8 addSubview:lblBg3];
        [card8 addSubview:lblBg4];
        [card8 addSubview:bar8];
        [card8 addSubview:world1];
        [card8 addSubview:world2];
        [card8 addSubview:world3];
        [card8 addSubview:world4];
        [card8 touchesMoved:nil withEvent:nil];
        [scrollView addSubview:card8];
        
        save1 = [UIButton buttonWithType:UIButtonTypeCustom];
        save1.frame = CGRectMake(172, fScrollHeight-66, 61, 61);
        [save1 setImage:[UIImage imageNamed:@"new_blue_save.png"] forState:UIControlStateNormal];
        
        
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"contentOffset"]) {
            //reload the last position
            double offset = [[NSUserDefaults standardUserDefaults] doubleForKey:@"contentOffset"];
            scrollView.contentOffset = CGPointMake(offset, 0);
            //update page control
            CGFloat pageWidth = scrollView.frame.size.width;
            page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
            pageControl.currentPage=page;
            
            c1HasBeenLocked = [[NSUserDefaults standardUserDefaults] boolForKey:@"c1HasBeenLocked"];
            c2HasBeenLocked = [[NSUserDefaults standardUserDefaults] boolForKey:@"c2HasBeenLocked"];
            c3HasBeenLocked = [[NSUserDefaults standardUserDefaults] boolForKey:@"c3HasBeenLocked"];
            c4HasBeenLocked = [[NSUserDefaults standardUserDefaults] boolForKey:@"c4HasBeenLocked"];
            
            cardLockedOnResume = [[NSUserDefaults standardUserDefaults] boolForKey:@"cardLockedOnResume"];
            
            if (cardLockedOnResume) {
                bCardOnResume = YES;
                [self lockOrUnlockCurrentCard:save1];
            }
            
            [self scrollViewDidEndDecelerating:scrollView];
            
        }
        
        [self.view insertSubview:scrollView atIndex:1];
        
        //Setup Buttons
        [save1 addTarget:self action:@selector(lockOrUnlockCurrentCard:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:save1];
        
        
        menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.frame = CGRectMake(11, fScrollHeight-66, 61, 61);
        [menuButton setImage:[UIImage imageNamed:@"new_blue_menu.png"] forState:UIControlStateNormal];
        [menuButton addTarget:self action:@selector(goToMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:menuButton];
        
        eraseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        eraseButton.frame = CGRectMake(90, fScrollHeight-66, 61, 61);
        [eraseButton setImage:[UIImage imageNamed:@"new_blue_erase.png"] forState:UIControlStateNormal];
        [eraseButton addTarget:self action:@selector(deleteTapper:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:eraseButton];
        
        infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        infoButton.frame = CGRectMake(250, fScrollHeight-66, 61, 61);
        //make sure this works below
        infoButton.tag = page +1;
        [infoButton setImage:[UIImage imageNamed:@"new_blue_info.png"] forState:UIControlStateNormal];
        [infoButton addTarget:self action:@selector(goToBackside:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:infoButton];
    }
    
    
    if (pageControl.currentPage == 6) {
        [infoButton setEnabled:NO];
        [eraseButton setEnabled:NO];
    }
    else if (pageControl.currentPage != 6 && bCardOnResume == NO){
        [infoButton setEnabled:YES];
        [eraseButton setEnabled:YES];
    }
    else
    {
        [eraseButton setEnabled:NO];
    }
    
    lastPage = page - 1;
    
}



- (void) viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    
    //if (locked)
        //scrollView.scrollEnabled = YES;
}
/*
- (void) createOverlay
{
    if (imageViewLayer == nil)
    {
        card1.userInteractionEnabled = NO;
        menuButton.enabled = NO;
        eraseButton.enabled = NO;
        save1.enabled = NO;
        infoButton.enabled = NO;
        
        imageViewLayer = [[UIImageView alloc] initWithFrame:CGRectMake(fXPosOverLay, fYPosOverLay, fOverLayWidth, fOverLayHeight)];
        UIImageView *bar1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fOverLayWidth, fOverlayBarHeight)];
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            imageViewLayer.image = [UIImage imageNamed:@"CardFront1-iPad@2x.png"];
            bar1.image = [UIImage imageNamed:@"bar1-iPad.png"];
        }
        else {
            
            imageViewLayer.image = [UIImage imageNamed:@"card1Image.png"];
            bar1.image = [UIImage imageNamed:@"bar1-iPhone.png"];
        }
        
        
        [imageViewLayer addSubview:bar1];
        [card1 addSubview:imageViewLayer];
        
        
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            float fCloseBtnWidth = 25;
            float fCloseBtnHeight = 25;
            float fXPos = (imageViewLayer.frame.size.width - fCloseBtnWidth) - 5;
            UIImageView *btnClose = [[UIImageView alloc] initWithFrame:CGRectMake(fXPos, 20, fCloseBtnWidth, fCloseBtnHeight)];
            btnClose.image = [UIImage imageNamed:@"btntutorialcloseipad.png"];
            [imageViewLayer addSubview:btnClose];
        }
        else
        {
            float fCloseBtnWidth = 22;
            float fCloseBtnHeight = 22;
            float fXPos = (imageViewLayer.frame.size.width - fCloseBtnWidth) - 10;
            UIImageView *btnClose = [[UIImageView alloc] initWithFrame:CGRectMake(fXPos, 50, fCloseBtnWidth, fCloseBtnHeight)];
            btnClose.image = [UIImage imageNamed:@"btntutorialcloseiphone.png"];
            [imageViewLayer addSubview:btnClose];
        }
    }
}
*/

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    if (pageControl.currentPage != 0)
    {
        return;
    }
    
    
    NSLog(@">>>>%d",pageControl.currentPage);
    
    [self removeOverlay];
}


- (void) removeOverlay
{
    if (imageViewLayer != nil)
    {
        [UIView animateWithDuration: 1.0
                         animations:^{
                             imageViewLayer.alpha = 0.0;
                         }
                         completion:^(BOOL finished) {
                             [imageViewLayer removeFromSuperview];
                             imageViewLayer = nil;
                             
                             card1.userInteractionEnabled = YES;
                             menuButton.enabled = YES;
                             eraseButton.enabled = YES;
                             save1.enabled = YES;
                             infoButton.enabled = YES;
                         }];
        
        
        NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
        [userdefault setBool:YES forKey:@"appstartedatleastonce"];
        [userdefault synchronize];
    }
}


-(void)unlockTheCurrentCard:(id)sender {
    UIButton *button = sender;
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        [button setImage:[UIImage imageNamed:@"new_ipad_blue_save.png"] forState:UIControlStateNormal];
    }
    else {
        [button setImage:[UIImage imageNamed:@"new_blue_save.png"] forState:UIControlStateNormal];
    }
    scrollView.scrollEnabled = NO;
    
    if (pageControl.currentPage != 6 || pageControl.currentPage != 0)
        [eraseButton setEnabled:YES];
    
    card1.userInteractionEnabled = YES;
    card2.userInteractionEnabled = YES;
    card3.userInteractionEnabled = YES;
    card4.userInteractionEnabled = YES;
    card5.userInteractionEnabled = YES;
    card6.userInteractionEnabled = YES;
    locked = YES;
}
-(IBAction)lockOrUnlockCurrentCard:(id)sender {
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        //scrollView.contentSize = CGSizeMake(4920, 708);
    }
    
    NSLog(@"Content Size: %f", scrollView.contentSize.width);
    UIButton *button = sender;
    
    if (locked) {
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
            [button setImage:[UIImage imageNamed:@"new_ipad_blue_edit.png"] forState:UIControlStateNormal];
        }
        else {
            [button setImage:[UIImage imageNamed:@"new_blue_edit.png"] forState:UIControlStateNormal];
        }
        scrollView.scrollEnabled = YES;
        [eraseButton setEnabled:NO];
        locked = NO;
        card1.userInteractionEnabled = NO;
        card2.userInteractionEnabled = NO;
        card3.userInteractionEnabled = NO;
        card4.userInteractionEnabled = NO;
        card5.userInteractionEnabled = NO;
        card6.userInteractionEnabled = NO;
        
        
        int thisCard = pageControl.currentPage + 1;
        
        if (thisCard == 1)
        {
            c1HasBeenLocked = YES;
        }
        else if (thisCard == 2)
        {
            c2HasBeenLocked = YES;
        }
        else if (thisCard == 3)
        {
            c3HasBeenLocked = YES;
        }
        else if (thisCard == 4)
        {
            c4HasBeenLocked = YES;
        }
        else if (thisCard == 5)
        {
            c5HasBeenLocked = YES;
        }
        else if (thisCard == 6)
        {
            c6HasBeenLocked = YES;
        }
        
        [self saveCurrentCard];
        
        
        /*
         //Load the drawn image from the first card onto the second card
         if (pageControl.currentPage == 0) {
         NSString *keyString = [NSString stringWithFormat:@"savedCard%d",1];
         NSLog(@"Contents of file: %@ ", [[NSUserDefaults standardUserDefaults] objectForKey:keyString]);
         UIImage *image = [UIImage imageWithContentsOfFile:[[NSUserDefaults standardUserDefaults] stringForKey:keyString]];
         UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
         imageView.tag = 99;
         [card2 addSubview:imageView];
         //makes sure the image gets saved to the card so the card state can be accurately resumed.
         [card2 addImageToCardImage:imageView];
         } else if (pageControl.currentPage == 2) {
         NSString *keyString = [NSString stringWithFormat:@"savedCard%d",3];
         NSLog(@"Contents of file: %@ ", [[NSUserDefaults standardUserDefaults] objectForKey:keyString]);
         UIImage *image = [UIImage imageWithContentsOfFile:[[NSUserDefaults standardUserDefaults] stringForKey:keyString]];
         UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
         imageView.tag = 99;
         [card4 addSubview:imageView];
         //makes sure the image gets saved to the card so the card state can be accurately resumed.
         [card4 addImageToCardImage:imageView];
         }
         */
        
    } else {
        [self unlockTheCurrentCard:sender];
        
    }
}

-(void)goToBackside:(id)sender {
    UIButton *button = sender;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [infoButton setEnabled:YES];
        if(!sidePanelIsVisibile)
            [self showHideSidePanel:nil];
        NSNumber *tag = [NSNumber numberWithInt:button.tag];
        [self populateSidePanelContentForTag:tag];
    } else {
        
        sidePanelIsVisibile = NO;
        //scrollView.scrollEnabled = NO;
        
        
        BacksideViewController* viewController = [[BacksideViewController alloc] initWithNibName:@"BacksideViewController" bundle:nil];
        viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        viewController.cardNumber = button.tag;
        viewController.delegate = self;
        [self presentViewController:viewController animated:YES completion:nil];
//        [self addChildViewController:backside];
//        backside.frontSide = self;
//        NSLog(@"Button tag: %d", button.tag);
//        if (button.tag == 1)
//            backside.view.frame = CGRectMake(0, 0, 300, 431);
//        if (button.tag == 2)
//            backside.view.frame = CGRectMake(300, 0, 300, 431);
//        if (button.tag < 7)
//            backside.view.frame = CGRectMake(((button.tag - 1)*300), 0, 300, 431);
//        else {
//            
//            // if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
//            //   backside.view.frame = CGRectMake(3936,0,984,708);
//            //} else {
//            backside.view.frame = CGRectMake(1200, 0, 300, 431);
//            //  }
//            
//        }
        
        /*
         [UIView beginAnimations:@"View Flip" context:nil];
         [UIView setAnimationDuration:1.25];
         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
         
         
         UIViewController *coming = backside;
         UIViewAnimationTransition transition;
         
         transition = UIViewAnimationTransitionFlipFromLeft;
         
         
         [UIView setAnimationTransition: transition forView:card5 cache:YES];
         [coming viewWillAppear:YES];
         //[card5 viewWillDisappear:YES];
         [card5 removeFromSuperview];
         [self.view insertSubview: coming.view atIndex:0];
         [going viewDidDisappear:YES];
         [coming viewDidAppear:YES];
         
         [UIView commitAnimations];
         
         */
    }
}



- (void) backButtonTapped
{
    NSLog(@"________Back ________");
    
    if (pageControl.currentPage == 6)
    {
        scrollView.scrollEnabled = YES;
    }
}


- (void) gotoMenuButtonTapped
{
    NSLog(@"gotoMenuButtonTapped ________");
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self goToMenu:nil];
}

-(void)saveCurrentCard {
    switch (pageControl.currentPage) {
        case 0:
            [card1 performSelectorInBackground:@selector(saveImage) withObject:nil];
            break;
        case 1:
            [card2 performSelectorInBackground:@selector(saveImage) withObject:nil];
            break;
        case 2:
            [card3 performSelectorInBackground:@selector(saveImage) withObject:nil];
            break;
        case 3:
            [card4 performSelectorInBackground:@selector(saveImage) withObject:nil];
            break;
        case 4:
            [card5 performSelectorInBackground:@selector(saveImage) withObject:nil];
            break;
        case 5:
            [card6 performSelectorInBackground:@selector(saveImage) withObject:nil];
            break;
    }
}
-(void)flipBackCard:(id)sender {
    BacksideViewController *backsideView = sender;
    
    
    NSLog(@"Flip back card");
    [UIView transitionFromView:backsideView.view
                        toView:card8
                      duration:0.3
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:nil];
    
    
    //fix this animation
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelay:3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self.view addSubview:save1];
    [self.view addSubview:menuButton];
    [self.view addSubview:eraseButton];
    [self.view addSubview:infoButton];
    [UIView commitAnimations];
    scrollView.scrollEnabled = YES;
    
}

-(IBAction)goToMenu:(id)sender {
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.bResumeCard = YES;
    
    [self saveCurrentCard];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setDouble:scrollView.contentOffset.x forKey:@"contentOffset"];
    
    //save the state of the button locks
    [prefs setBool:c1HasBeenLocked forKey:@"c1HasBeenLocked"];
    [prefs setBool:c2HasBeenLocked forKey:@"c2HasBeenLocked"];
    [prefs setBool:c3HasBeenLocked forKey:@"c3HasBeenLocked"];
    [prefs setBool:c4HasBeenLocked forKey:@"c4HasBeenLocked"];
    [prefs setBool:c5HasBeenLocked forKey:@"c5HasBeenLocked"];
    [prefs setBool:c6HasBeenLocked forKey:@"c6HasBeenLocked"];
    
    BOOL locked = NO;
    //reverse the bool to save it
    if (c1HasBeenLocked || c2HasBeenLocked || c3HasBeenLocked || c4HasBeenLocked || c5HasBeenLocked || c6HasBeenLocked) {
        locked = YES;
    }
    
    [prefs setBool:locked forKey:@"cardLockedOnResume"];
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             [sideMenu setFrame:CGRectMake(-396, 0, 461, 748)];
                             [card1 setHidden:YES];
                             [save1 setHidden:YES];
                             [eraseButton setHidden:YES];
                         }
                         completion:^(BOOL finished){
                             if(finished) {
                                 sidePanelIsVisibile = NO;
                                 [self.navigationController popToRootViewControllerAnimated:NO];
                             }
                         }];
        
        /*
         //load the storyboard (
         UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
         //load traceview controller from storyboard
         ViewController *controller = (ViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"ViewController"];
         controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
         [self.navigationController presentModalViewController:controller animated:YES];
         */
        
    } else {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)infoTapped:(id)sender {
    
}
-(IBAction)deleteTapper:(id)sender {
    
    switch (pageControl.currentPage) {
        case 0:
            [card1 clearView];
            break;
        case 1: {
            [card2 clearView];
            
            //erase any subviews that were loaded from previous cards
            NSArray *views = [card2 subviews];
            for (UIView *view in views) {
                if (view.tag == 99)
                    [view removeFromSuperview];
            }
        }
            break;
        case 2:
            [card3 clearView];
            break;
        case 3: {
            [card4 clearView];
            //erase any subviews that were loaded from previous cards
            NSArray *views = [card4 subviews];
            for (UIView *view in views) {
                if (view.tag == 99)
                    [view removeFromSuperview];
            }
        } break;
        case 4: {
            [card5 clearView];
            //erase any subviews that were loaded from previous cards
            NSArray *views = [card5 subviews];
            for (UIView *view in views) {
                if (view.tag == 99)
                    [view removeFromSuperview];
            }
        }
            break;
        case 5: {
            [card6 clearView];
            //erase any subviews that were loaded from previous cards
            NSArray *views = [card6 subviews];
            for (UIView *view in views) {
                if (view.tag == 99)
                    [view removeFromSuperview];
            }
            break;
        }
        default:
            break;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"segue: %@ ", segue.identifier);
}

-(void)lockPage: (int) page {
    
    if (page >= lastPage && page != 6) {
        
        //only unlock 1-4 if the card has never been locked before
        int thisCard = pageControl.currentPage + 1;
        if (thisCard == 1 && !c1HasBeenLocked) {
            [self unlockTheCurrentCard:save1];
        } else if (thisCard == 2 && !c2HasBeenLocked) {
            [self unlockTheCurrentCard:save1];
        } else if (thisCard == 3 && !c3HasBeenLocked) {
            [self unlockTheCurrentCard:save1];
        } else if (thisCard == 4 && !c4HasBeenLocked) {
            [self unlockTheCurrentCard:save1];
        }else if (thisCard == 5 && !c5HasBeenLocked) {
            [self unlockTheCurrentCard:save1];
        }else if (thisCard == 6 && !c6HasBeenLocked) {
            [self unlockTheCurrentCard:save1];
        }
        
    }

}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setDouble:scrollView.contentOffset.x forKey:@"contentOffset"];
    
    
    [save1 setEnabled:YES];
    [infoButton setEnabled:YES];
    [menuButton setEnabled:YES];
    
    NSLog(@"Scroll view content offset: %f",_scrollView.contentOffset.x);
    
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    BOOL diffPage = pageControl.currentPage != page;
    pageControl.currentPage=page;
    infoButton.tag  = page + 1;
    
    if (page + 1 == 7) {
        //if(!sidePanelIsVisibile && diffPage)
            [infoButton setEnabled:NO];
        [eraseButton setEnabled:NO];
        [save1 setEnabled:NO];
    } else {
        [save1 setEnabled:YES];
        [infoButton setEnabled:YES];
        [eraseButton setEnabled:YES];
    }
    
    if (!card1.userInteractionEnabled)
        [eraseButton setEnabled:NO];
    
    [self lockPage: page];
    
    lastPage = page;
    if (pageControl.currentPage <6) { //if (sidePanelIsVisibile && pageControl.currentPage < 4)
        NSNumber *tag = [NSNumber numberWithInt:pageControl.currentPage +1];
        [self performSelectorOnMainThread:@selector(populateSidePanelContentForTag:) withObject:tag waitUntilDone:NO];
        //[self performSelectorInBackground:@selector(populateSidePanelContentForTag:) withObject:[NSNumber numberWithInt:1]];
    }
    //if (pageControl.currentPage == 6 && sidePanelIsVisibile)
    
    if (sidePanelIsVisibile && diffPage)
        [self showHideSidePanel:self];
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [imgCardBg setImage:[UIImage imageNamed:@"cardstartedinner.png"]];
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        [imgCardBg setImage:[UIImage imageNamed:@"cardstartedinner_iphone.png"]];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)_scrollView {
    if (_scrollView.contentOffset.x > 0) {
        [save1 setEnabled:NO];
        [infoButton setEnabled:NO];
        [eraseButton setEnabled:NO];
        [menuButton setEnabled:NO];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    //[card1 saveImage];
    //[card1 clearView];
    
    //[card2 saveImage];
    //[card2 clearView];
    
    // [card3 saveImage];
    //[card3 clearView];
    
    //[card4 saveImage];
    //[card4 clearView];
    
    
    //[card1 consolidateDrawImage];
    //[card2 consolidateDrawImage];
    //[card3 consolidateDrawImage];
    //[card4 consolidateDrawImage];
    
    // Dispose of any resources that can be recreated.
}

- (IBAction)showHideSidePanel:(id)sender {

    if (sidePanelIsVisibile && sender != nil) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             [sideMenu setFrame:CGRectMake(-396, 0, 475, 768)];
                         }
                         completion:^(BOOL finished){
                             if(finished) {
                                 sidePanelIsVisibile = NO;
                                 if(pageControl.currentPage == 6) {
                                     [infoButton setEnabled:NO];
                                 }
                             }
                         }];
        
    } else if(!sidePanelIsVisibile) {
        UIButton *button = sender;
        if (pageControl.currentPage == 6 && button != nil && button.tag == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pick A World" message:@"Please tap a world to view information on this card first" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            int tag;
            if (pageControl.currentPage < 6)
                tag = pageControl.currentPage +1;
            else {
                tag = button.tag;
            }
            
            // [self populateSidePanelContentForTag:tag];
            [UIView animateWithDuration:0.3
                             animations:^{
                                 [sideMenu setFrame:CGRectMake(0, 0, 475, 768)];
                             }
                             completion:^(BOOL finished){ if(finished) {
                sidePanelIsVisibile = YES;
                // CGRect frame = backside.textView.frame;
                //frame.size.height += 1;
                //backside.textView.frame = frame;
                [backside.textView setNeedsDisplay];
                [backside.textView layoutSubviews];
            } }];
        }
    }
}

-(void)clearTopSidePanelView {
    
    //clear all subviews of the sideview
    NSArray *subviews = [sideMenu subviews];
    if ([subviews count] == 3)
        [[subviews lastObject] removeFromSuperview];
    
}
-(void)populateSidePanelContentForTag:(NSNumber *)tagNumber {
    
    int tag = [tagNumber intValue];
    NSLog(@"The Tag: %d",tag);
    if (tag != lastTag) {
        [self clearTopSidePanelView];
        backside = [[BacksideViewController alloc] initWithNibName:@"BacksideViewController-iPad" bundle:nil];
        [self addChildViewController:backside];
        backside.cardNumber = tag;
        backside.frontSide = self;
        backside.delegate = self;
        [backside.textView setNeedsDisplay];
        [backside.textView layoutSubviews];
        [sideMenu addSubview:backside.view];
        [backside.textView setNeedsDisplay];
        [backside.textView layoutSubviews];
        lastTag = tag;
    }
}

-(void)resetScrollView {
    [card1 clearView];
    [card1 clearView];
    [card2 clearView];
    [card3 clearView];
    [card4 clearView];
    [card5 clearView];
    [card6 clearView];
    [scrollView setContentOffset:CGPointZero animated:YES];
    [self performSelector:@selector(scrollViewDidEndDecelerating:) withObject:scrollView afterDelay:.5];
    [self performSelector:@selector(checkLockOrUnlockAfterReset) withObject:nil afterDelay:.6];
    
    
    //   [self performSelector:@selector(lockOrUnlockCurrentCard:) withObject:nil afterDelay:.6];
    
}

//Make sure the card get's unlocked after starting a new session
-(void)checkLockOrUnlockAfterReset {
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        [save1 setImage:[UIImage imageNamed:@"new_ipad_blue_save.png"] forState:UIControlStateNormal];
    }
    else {
        [save1 setImage:[UIImage imageNamed:@"lockButton@2x.png"] forState:UIControlStateNormal];
    }
    scrollView.scrollEnabled = NO;
    [save1 setEnabled:YES];
    
    if (pageControl.currentPage != 6)
        [eraseButton setEnabled:YES];
    
    card1.userInteractionEnabled = YES;
    card2.userInteractionEnabled = YES;
    card3.userInteractionEnabled = YES;
    card4.userInteractionEnabled = YES;
    card5.userInteractionEnabled = YES;
    card6.userInteractionEnabled = YES;

    locked = YES;
}

- (void)iPadStartNew:(id)sender {
    //clears the saved images
    for (int x = 1; x <=6; x++) {
        // drawImage.image = nil;
        NSString *imageString = [NSString stringWithFormat:@"/card%d.png", x];
        
        //saves a blank image over the image
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        path = [path stringByAppendingString:imageString];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        [fileMgr removeItemAtPath:path error:nil];
    }
    
    //clear the saved scroll view position
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs removeObjectForKey:@"contentOffset"];
    [prefs setBool:NO forKey:@"c1HasBeenLocked"];
    [prefs setBool:NO forKey:@"c2HasBeenLocked"];
    [prefs setBool:NO forKey:@"c3HasBeenLocked"];
    [prefs setBool:NO forKey:@"c4HasBeenLocked"];
    [prefs setBool:NO forKey:@"c5HasBeenLocked"];
    [prefs setBool:NO forKey:@"c6HasBeenLocked"];
    [prefs setBool:NO forKey:@"cardLockedOnResume"];
    
    
    c1HasBeenLocked = NO;
    c2HasBeenLocked = NO;
    c3HasBeenLocked = NO;
    c4HasBeenLocked = NO;
    c5HasBeenLocked = NO;
    c6HasBeenLocked = NO;
    
    
    
    if (sidePanelIsVisibile)
        [self showHideSidePanel:self];
    
    [self resetScrollView];
}

-(IBAction)btnTest:(id)sender
{

}

-(void)applicationWillTerminate:(NSNotification *)notification {
    NSLog(@"_view: applicationWillTerminate");
}

@end
