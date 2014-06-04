//
//  ViewController.m
//  InterVarsity
//
//  Created by Ben Dennis on 11/29/12.
//  Copyright (c) 2012 My Mobile Fans. All rights reserved.
//

#import "ViewController.h"
#import "SHK.h"
#import "SHKTextMessage.h"
#import "SHKTwitter.h"
#import "SHKFacebook.h"
#import "SHKMail.h"
#import "TraceViewController.h"
#import "AboutViewController.h"
#import "TutorialViewController.h"
#import "AppDelegate.h"


#define HEIGHT_IPHONE_5 568
#define IS_IPHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds ].size.height == HEIGHT_IPHONE_5)


@interface ViewController ()

@end

@implementation ViewController
@synthesize popoverController;

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"--------------------------HomeView--------------------------");

    /*
    NSLog(@"--->%f, %f, %f, %f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    NSLog(@"--->%f, %f, %f, %f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
     */
    
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.mainViewController = self;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        
        [newLabel setFont:[UIFont fontWithName:@"BellGothic Blk BT" size:32]];
        [worldLabel setFont:[UIFont fontWithName:@"BellGothic Blk BT" size:32]];
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
            [UIView animateWithDuration:0.3
                             animations:^{
                             }
                             completion:^(BOOL finished){
                                 if(finished) {
                                     
                                 }
                             }];

        }
    } else {
        
        [newLabel setFont:[UIFont fontWithName:@"BellGothic Blk BT" size:26]];
        [worldLabel setFont:[UIFont fontWithName:@"BellGothic Blk BT" size:26]];
    }


}


BOOL IS_IPHONE5_RETINA(void) {
    BOOL isiPhone5Retina = NO;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([UIScreen mainScreen].scale == 2.0f) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            
            if(result.height == 960){
                NSLog(@"iPhone 4, 4s Retina Resolution");
            }
            if(result.height == 1136){
                NSLog(@"iPhone 5 Resolution");
                isiPhone5Retina = YES;
            }
        } else {
            NSLog(@"iPhone Standard Resolution");
        }
    }
    return isiPhone5Retina;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"startNew"]) {
        
        [self hidePanel];
        
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
        [prefs removeObjectForKey:@"contentOffset"];
        [prefs setBool:NO forKey:@"c1HasBeenLocked"];
        [prefs setBool:NO forKey:@"c2HasBeenLocked"];
        [prefs setBool:NO forKey:@"c3HasBeenLocked"];
        [prefs setBool:NO forKey:@"c4HasBeenLocked"];
        [prefs setBool:NO forKey:@"c54HasBeenLocked"];
        [prefs setBool:NO forKey:@"c6HasBeenLocked"];
        [prefs setBool:NO forKey:@"cardLockedOnResume"];
    }
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

	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareApp:(id)sender {
    
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Share App" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Twitter",@"Facebook", @"Text Message", @"Email", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        //these bounds force the sheet to appear to the right 
        [sheet showFromRect:CGRectMake(75, 110, 144, 708) inView:self.view animated:YES];
    } else {
        /* Device is an iPhone*/
        [sheet showInView:self.view];
    }
}

- (IBAction)iPadStartNew:(id)sender {
    
    /*
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
    
    [self resumeiPadSession:nil];
     */
    
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    BOOL bOpenedOnce = [[userdefault objectForKey:@"appstartedatleastonce"] boolValue];
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate startNewCard];
    
    if(bOpenedOnce == NO) {
        [userdefault setBool:YES forKey:@"appstartedatleastonce"];
        [userdefault synchronize];
        [self btnTutorialClick:nil];
    }
    else {
        appDelegate.bResumeCard = NO;
        [appDelegate resumeCard:nil];
    }
    
}

- (IBAction)aboutTapped:(id)sender {
    
    
    //AboutViewController *aboutView = [[AboutViewController alloc] initWithNibName:@"AboutView-iPad" bundle:nil];
    //aboutView.contentSizeForViewInPopover = CGSizeMake(320, 445);
    //UIPopoverController* aPopover = [[UIPopoverController alloc]
    //                                 initWithContentViewController:aboutView];
    // aPopover.delegate = self;
    
    // Store the popover in a custom property for later use.
    //self.popoverController = aPopover;
    //self.popoverController = aPopover;
    //[self.popoverController presentPopoverFromRect:CGRectMake(175,550,167,167) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
    //[aPopover presentPopoverFromBarButtonItem:sender
    //                             permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    /*
     popup = [[SNPopupView alloc] initWithContentView:aboutView.view contentSize:aboutView.view.bounds.size];
     [popup showAtPoint:CGPointMake(900,20) inView:self.view animated:YES];
     */
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController-iPad" bundle:nil];
        [self.navigationController pushViewController:controller animated:NO];
        
    }
    else
    {
        AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController-iPhone" bundle:nil];
        [self.navigationController pushViewController:controller animated:NO];
    }
    
    
    /*
    [UIView animateWithDuration:0.3
                     animations:^{
                         [startingMenu setFrame:CGRectMake(-400, 0, 400, 748)];
                     }
                     completion:^(BOOL finished){ if(finished) {
        
        
        //load the storyboard (
        //load traceview controller from storyboard
        AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutView-iPad" bundle:nil];
        [self.navigationController pushViewController:controller animated:NO];
    }
                     }];
     */
}



-(IBAction)btnTutorialClick:(id)sender
{
    NSLog(@"--------------------------TutorialButton--------------------------");


}


-(IBAction)resumeiPadSession:(id)sender {
    
    /*[UIView animateWithDuration:0.3
                     animations:^{
                         [startingMenu setFrame:CGRectMake(-400, 0, 400, 748)];
                     }
                     completion:^(BOOL finished){ if(finished) {
        
        
        //load the storyboard (
        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        //load traceview controller from storyboard
        TraceViewController *controller = (TraceViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"TraceViewControlleriPad"];
        
        if (sender != nil)
            controller.bResume = YES;
        
        [self.navigationController pushViewController:controller animated:NO];
    }
                     }];
     */
    
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate resumeCard:sender];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    int buttonInt = buttonIndex;
    
    if (buttonInt == 0) {
            NSURL * url = [NSURL URLWithString:@"http://urlgeni.us/bigstoryapp"];
            SHKItem *item = [SHKItem URL:url title:@"Share the #gospel with the Big Story app from @IVWitness & @INTERVARSITYusa http://urlgeni.us/bigstoryapp" contentType:SHKURLContentTypeWebpage];
            // Share the item
            [SHKTwitter shareItem:item];
    } if (buttonInt == 1) {
        NSURL * url = [NSURL URLWithString:@"http://urlgeni.us/bigstoryapp"];
        SHKItem *item = [SHKItem URL:url title:@"I’ve been using InterVarsity Christian Fellowship’s Big Story app to share the gospel. You can download it for free on iTunes and Google Play. http://urlgeni.us/bigstoryapp" contentType:SHKURLContentTypeWebpage];
        // Share the item
        [SHKFacebook shareItem:item];
    } if (buttonInt == 2) {
        NSURL * url = [NSURL URLWithString:@"http://urlgeni.us/bigstoryapp"];
        
        SHKItem *item = [SHKItem URL:url title:@"Share the gospel with InterVarsity’s Big Story app. Check it out:" contentType:SHKURLContentTypeWebpage];
        item.text = @"Share the gospel with InterVarsity’s Big Story app. Check it out: http://urlgeni.us/bigstoryapp";
        [SHKTextMessage shareItem:item];
    } if (buttonInt == 3) {
        NSURL * url = [NSURL URLWithString:@"http://urlgeni.us/bigstoryapp"];
        SHKItem *item = [SHKItem URL:url title:@"Check out InterVarsity’s Big Story app" contentType:SHKURLContentTypeWebpage];
        item.text = @"Hey there! I’ve been using InterVarsity Christian Fellowship’s Big Story app and thought you might like it. It’s a tool to help you present the gospel anywhere and anytime right from your smartphone or tablet. Check it out: http://urlgeni.us/bigstoryapp ";
        [SHKMail shareItem:item];
    }
}


-(void)hidePanel {

    
  }

@end
