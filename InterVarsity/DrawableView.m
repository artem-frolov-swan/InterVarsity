//
//  DrawableView.m
//  InterVarsity
//
//  Created by Ben Dennis on 11/30/12.
//
//

#import "DrawableView.h"
#import <QuartzCore/QuartzCore.h>

@implementation DrawableView

@synthesize cardNumber;

- (id)initWithFrame:(CGRect)_frame andCardNumber:(int)_cardNumber {
    frame = _frame;
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    frame.origin.x = 0;
    
    firstTouch = YES;
    cardNumber = _cardNumber;
    NSLog(@"Card number: %d", cardNumber);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *keyString = [NSString stringWithFormat:@"savedCard%d",cardNumber];
    NSString *imageString = [NSString stringWithFormat:@"/card%d.png", cardNumber];
    
    NSLog(@"Contents of file: %@ ", [[NSUserDefaults standardUserDefaults] objectForKey:keyString]);
    
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSUserDefaults standardUserDefaults] stringForKey:keyString]];
    drawImage = [[UIImageView alloc] initWithImage:image];
    
        [drawImage setFrame:frame];
        [self addSubview:drawImage];
        UIGraphicsBeginImageContext(CGSizeMake(frame.size.width,frame.size.height));
        [drawImage.image drawInRect:CGRectMake(0, 0, 1025, 708)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 6);
    } else {
        /* Device is an iPhone*/
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5);
    }
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0, 255, 1);
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0,0);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 1,1);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        
        [drawImage setFrame:frame];

     


    
   // drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self addSubview:drawImage];
    [self touchesBegan:nil withEvent:nil];
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches]anyObject];
    
    location = [touch locationInView:touch.view];
    lastClick = [NSDate date];
    
    lastPoint = [touch locationInView:self];
    lastPoint.y -= 0;
    
    [super touchesBegan:touches withEvent:event];
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    
    UITouch *touch = [touches anyObject];
    currentPoint = [touch locationInView:self];
    
    UIGraphicsBeginImageContext(CGSizeMake(frame.size.width,frame.size.height));
    [drawImage.image drawInRect:frame];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 6);
    } else {
        /* Device is an iPhone*/
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5);
    }
    
    
    if (firstTouch){
          CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0, 255, 0);
        firstTouch = NO;
    } else {
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0, 255, 1);
    }
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    [drawImage setFrame:frame];
    drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    lastPoint = currentPoint;
    
    CGContextRelease(UIGraphicsGetCurrentContext());
    
    [self addSubview:drawImage];    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)saveImage {
    
    UIImage *image = drawImage.image;
    
    NSString *imageString = [NSString stringWithFormat:@"/card%d.png", cardNumber];
    NSString *keyString = [NSString stringWithFormat:@"savedCard%d",cardNumber];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingString:imageString];
    //save the image to the user app directory
    [imageData writeToFile:path atomically:YES];
    NSLog(@"Key string: %@ and Path: %@", keyString, path);
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

    [standardUserDefaults setObject:path forKey:keyString];
    [standardUserDefaults synchronize];
    NSLog(@"Contents of file: %@ ", [standardUserDefaults stringForKey:keyString]);

}

-(void)addImageToCardImage:(UIImageView *)imageView {
    [drawImage addSubview:imageView];
    drawImage.image = [self imageFromView:drawImage];
    [self saveImage];
}


- (UIImage*)imageFromView:(UIView *)view
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [view bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // -renderInContext: renders in the coordinate space of the layer,
    // so we must first apply the layer's geometry to the graphics context
    CGContextSaveGState(context);
    // Center the context around the view's anchor point
    CGContextTranslateCTM(context, [view center].x, [view center].y);
    // Apply the view's transform about the anchor point
    CGContextConcatCTM(context, [view transform]);
    // Offset by the portion of the bounds left of and above the anchor point
    CGContextTranslateCTM(context,
                          -[view bounds].size.width * [[view layer] anchorPoint].x,
                          -[view bounds].size.height * [[view layer] anchorPoint].y);
    
    // Render the layer hierarchy to the current context
    [[view layer] renderInContext:context];
    
    // Restore the context
    CGContextRestoreGState(context);
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRelease (context);
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)reloadImage {
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"/card%d.png", cardNumber]]];
    drawImage = [[UIImageView alloc] initWithImage:image];
    [drawImage setFrame:frame];
    
    [self addSubview:drawImage];
}

-(void)consolidateDrawImage {
    
    drawImage.image = [self imageFromView:drawImage];
    NSLog(@"Number is subviews: %i", self.subviews.count);
    
    NSArray *subviews = [drawImage subviews];

    for (UIView *viewToRemove in subviews) {
        [viewToRemove removeFromSuperview];
    }
    
}

- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}

-(void)clearView {
    drawImage.image = nil;
    
    NSArray *viewsToRemove = [drawImage subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    NSString *imageString = [NSString stringWithFormat:@"/card%d.png", cardNumber];

    
    //saves a blank image over the image
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingString:imageString];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    [fileMgr removeItemAtPath:path error:nil];

    
}
@end
