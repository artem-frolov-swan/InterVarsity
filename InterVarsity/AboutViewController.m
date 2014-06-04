//
//  AboutViewController.m
//  InterVarsity
//
//  Created by Ben Dennis on 12/10/12.
//  Copyright (c) 2012 My Mobile Fans. All rights reserved.
//

#import "AboutViewController.h"


@interface AboutViewController ()

@end

@implementation AboutViewController

@synthesize webview, textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString * htmlString = [NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:Trebuchet MS; font-size:14px; } a { color:#00aeef; text-decoration:none; }</style></head><body><p>The Big Story Gospel App is a free mobile app from <a href=\"http://evangelism.intervarsity.org\">InterVarsity Christian Fellowship/USA.</a></br> </br> Available on iPhone, Android, and iPad, the app allows users to present the gospel by drawing a diagram on screen, accompanied by a suggested script and Bible references.</br> </br> This material has been adapted from James Choung’s  <em>True Story,</em> published by InterVarsity Press, 2008.</br> <br>For more information about the Big Story Gospel Presentation, visit the <a href=\"http://evangelism.intervarsity.org\">InterVarsity Evangelism website</a> </br><br><a href=\"http://facebook.urlgeni.us/intervarsityevangelism\">Like InterVarsity Evangelism</a></br> <br><a href=\"http://twitter.urlgeni.us/ivwitness\">Follow IVWitness</a> </br> <br> Copyright © 2013 InterVarsity Christian Fellowship/USA All rights reserved <br> <br> Powered By <a href=\"http://www.mymobilefans.com\" target=\"_blank\"> My Mobile Fans </a> </div></p><br></body></html>"];


    webview.delegate = self;
    [webview loadHTMLString:htmlString baseURL:nil];
    
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
	// Do any additional setup after loading the view.
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
   
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        
        if([inRequest.URL.scheme compare:@"pray"] == 0) {
            
            return NO;
        }
        else {
            [[UIApplication sharedApplication] openURL:[inRequest URL]];
            return NO;
        }
    }
    
    return YES;
}


- (IBAction)btnBack:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        //[self dismissPopoverAnimated:YES];
    } else {
      [self dismissViewControllerAnimated:YES completion:nil];  
    }  
}


@end
