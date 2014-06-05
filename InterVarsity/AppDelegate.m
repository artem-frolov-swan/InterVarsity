//
//  AppDelegate.m
//  InterVarsity
//
//  Created by Ben Dennis on 11/29/12.
//  Copyright (c) 2012 My Mobile Fans. All rights reserved.
//

#import "AppDelegate.h"
#import "DefaultSHKConfigurator.h"
#import "SHKConfiguration.h"
#import "TraceViewController.h"

@implementation AppDelegate
@synthesize mainViewController;
@synthesize bResumeCard;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    DefaultSHKConfigurator *configurator = [[DefaultSHKConfigurator alloc] init];
    [SHKConfiguration sharedInstanceWithConfigurator:configurator];
    
    bResumeCard = NO;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (void) startNewCard
{
    bResumeCard = NO;
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
    
}

-(IBAction)resumeCard:(id)sender {
    [UIView animateWithDuration:0.3
                     animations:^{
                     }
                     completion:^(BOOL finished){ if(finished) {
        
        
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            //load the storyboard (
            UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
            //load traceview controller from storyboard
            TraceViewController *controller = (TraceViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"TraceViewControlleriPad"];
            
            if (sender != nil)
                controller.bResume = YES;
            
            [mainViewController.navigationController pushViewController:controller animated:NO];
        }
        else
        {
            //load the storyboard (
            UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
            //load traceview controller from storyboard
            TraceViewController *controller = (TraceViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"TraceViewControlleriPhone"];
            
            if (sender != nil)
                controller.bResume = YES;
            
            [mainViewController.navigationController pushViewController:controller animated:NO];
        }
    }
    }];
    
}

@end
