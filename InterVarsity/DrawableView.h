//
//  DrawableView.h
//  InterVarsity
//
//  Created by Ben Dennis on 11/30/12.
//
//

#import <UIKit/UIKit.h>

@interface DrawableView : UIView {
    
    CGPoint lastPoint;
    CGPoint moveBackTo;
    CGPoint currentPoint;
    CGPoint location;
    NSDate *lastClick;
    BOOL mouseSwiped;
    UIImageView *drawImage;
    BOOL firstTouch;
    CGRect frame;
}

-(void)consolidateDrawImage;
-(void)clearView;
-(void)saveImage;
-(void)reloadImage;
@property (nonatomic, assign) int cardNumber;
- (id)initWithFrame:(CGRect)frame andCardNumber:(int)_cardNumber;
-(void)addImageToCardImage:(UIImageView *)imageView;

@end
