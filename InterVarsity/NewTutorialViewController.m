//
//  NewTutorialViewController.m
//  intervarsity
//
//  Created by Artem Frolow on 6/3/14.
//  Copyright (c) 2014 My Mobile Fans. All rights reserved.
//

#import "NewTutorialViewController.h"
#import "TutorialViewController.h"

#define HEIGHT_IPHONE_5 568
#define IS_IPHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds ].size.height == HEIGHT_IPHONE_5)

@interface NewTutorialViewController ()
@property (strong, nonatomic) IBOutlet UIButton *overlayButton;
@property (strong, nonatomic) IBOutlet UIImageView *topBarImage;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *overlayBtnConstrHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *navbarConstrHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *overlayBtnConstrWidth;

@end

@implementation NewTutorialViewController

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
    if (IS_IPHONE) {
        if (!IS_IPHONE_5) {

            _overlayBtnConstrHeight.constant = 149.0;
            _overlayBtnConstrWidth.constant = 100.0;
            [_overlayButton setImage:[UIImage imageNamed:@"overlay_image_iphone4"] forState:UIControlStateNormal];
            _navbarConstrHeight.constant = 53.0;
            _topBarImage.image = [UIImage imageNamed:@"new_tutorial_navbar_iphone4"];
        }
    }




}


- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES ];
}


- (IBAction)deoButtonTapped:(id)sender {


}


- (IBAction)overlayButtonTapped:(id)sender {

    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        TutorialViewController *controller = [[TutorialViewController alloc]
                                                initWithNibName:@"TutorialViewController-iPad" bundle:nil];
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        TutorialViewController *controller = [[TutorialViewController alloc] initWithNibName:@"TutorialViewController-iPhone" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
