//
//  DemoViewController.m
//  intervarsity
//
//  Created by Artem Frolow on 6/4/14.
//  Copyright (c) 2014 My Mobile Fans. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@property (nonatomic, strong) NSString *videoURL;
@property(nonatomic, strong) IBOutlet UIWebView *videoView;
@property(nonatomic, strong) NSString *videoHTML;
@end

@implementation DemoViewController

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
    self.videoURL = @"http://youtube.com/embed/uv15GygmW2Y";
    _videoView.opaque = NO;
    
    [self embedYouTube];
}
- (void)embedYouTube {
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        _videoHTML = [NSString stringWithFormat:@"\
                      <html>\
                      <head>\
                      <style type=\"text/css\">\
                      iframe {position:absolute; top:0%%; margin-top:0px; margin-left:77px; }\
                      body {background-color:#000; margin:0;}\
                      </style>\
                      </head>\
                      <body>\
                      <iframe width=\"85%%\" height=\"652px\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
                      </body>\
                      </html>", _videoURL];
        
        [_videoView loadHTMLString:_videoHTML baseURL:nil];

    }
    else
    {
        _videoHTML = [NSString stringWithFormat:@"\
                      <html>\
                      <head>\
                      <style type=\"text/css\">\
                      iframe {position:absolute; top:50%%; margin-top:-130px;}\
                      body {background-color:#000; margin:0;}\
                      </style>\
                      </head>\
                      <body>\
                      <iframe width=\"100%%\" height=\"240px\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
                      </body>\
                      </html>", _videoURL];
        
        [_videoView loadHTMLString:_videoHTML baseURL:nil];

        
    }
}


- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES ];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
