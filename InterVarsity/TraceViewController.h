//
//  TraceViewController.h
//  InterVarsity
//
//  Created by Ben Dennis on 11/29/12.
//  Copyright (c) 2012 My Mobile Fans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawableView.h"
#import "BacksideViewController.h"


//#import "BacksideViewController.h"
@class BacksideViewController;
@protocol BacksideViewDelegate;

@interface TraceViewController : UIViewController <UIScrollViewDelegate, BacksideViewDelegate> {
    //BacksideViewController *backside;
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIImageView* imgCardBg;
    
    
    IBOutlet UIButton *eraseButton;
    IBOutlet UIButton *save1;
    IBOutlet UIButton *menuButton;
    IBOutlet UIButton *infoButton;
    
    IBOutlet UIView *whereAreYouView;
    IBOutlet UIView *healBackView;
    
    
    DrawableView *card1;
    DrawableView *card2;
    DrawableView *card3;
    DrawableView *card4;
    DrawableView *card5;
    DrawableView *card6;
    UIView *card8;
    
    float fXPosOverLay;
    float fYPosOverLay;
    float fOverLayWidth;
    float fOverLayHeight;
    float fOverlayBarHeight;
    
    
    NSMutableSet *recyledPages;
    NSMutableSet *visiblePages;

    UIImageView* imageViewLayer;
    
    TraceViewController *frontSide;
    
    IBOutlet UIPageControl *pageControl;
    int lastPage;
    
    BOOL sidePanelIsVisibile;
    IBOutlet UIView *sideMenu;
    int lastTag;
    
    BOOL c1HasBeenLocked, c2HasBeenLocked, c3HasBeenLocked, c4HasBeenLocked, c5HasBeenLocked, c6HasBeenLocked, cardLockedOnResume;
}


- (void)iPadStartNew:(id)sender;
- (IBAction)showHideSidePanel:(id)sender;

-(IBAction)lockOrUnlockCurrentCard;
-(void)nextCard;
-(void)previousCard;
-(IBAction)goToMenu:(id)sender;
-(IBAction)infoTapped:(id)sender;
-(IBAction)deleteTapper:(id)sender;
-(void)flipBackCard:(id)sender;

-(IBAction)btnTest:(id)sender;

-(DrawableView *)dequeueRecycledPage;
-(void)tilePages;

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer ;

@property (nonatomic, strong) BacksideViewController *backside;
@property (nonatomic,strong)TraceViewController *frontSide;
@property (nonatomic, assign) int currentCard;
@property (nonatomic, assign) BOOL locked;
@property (readwrite, assign) BOOL bResume;
@property (readwrite, assign) BOOL noOverlay;



@end
