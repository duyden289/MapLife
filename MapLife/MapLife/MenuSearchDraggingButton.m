//
//  MenuSearchDraggingButton.m
//  MapLife
//
//  Created by DenNH on 12/19/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import "MenuSearchDraggingButton.h"

CGFloat const MaximumDraggingButton = 150;
CGFloat const MinimumDraggingBUtton = 30;
/**
 *  Image dragging button menu search
 */
NSString *const ImageDraggingButtonNormal = @"menusearch_n";
NSString *const ImageDraggingButtonPress = @"menusearch_p";

const UIEdgeInsets MenuInsetsBackground = {30, 30, 5, 5};

@interface MenuSearchDraggingButton ()

/**
 *  Point Begin - End dragg
 */
@property(nonatomic, assign) CGPoint pointBeginDragg;
@property(nonatomic, assign) CGPoint pointEndDragg;

@end
@implementation MenuSearchDraggingButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];

  if (self) {

    [self setBackgroundImage:[UIImage imageNamed:ImageDraggingButtonNormal]
                    forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:ImageDraggingButtonPress]
                    forState:UIControlStateHighlighted];
  }
  return self;
}
/**
 *  Touches began button dragging
 *
 *  @param touches Collection of touch event
 *  @param event   Event touch
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  UITouch *touchBegin = [touches anyObject];
  self.pointBeginDragg = [touchBegin locationInView:self.window];

  if (self.disableDragging) {
    [self
        setBackgroundImage:[[UIImage imageNamed:ImageDraggingButtonNormal]
                               resizableImageWithCapInsets:MenuInsetsBackground]
                  forState:UIControlStateNormal];
  } else {
    [self
        setBackgroundImage:[[UIImage imageNamed:ImageDraggingButtonPress]
                               resizableImageWithCapInsets:MenuInsetsBackground]
                  forState:UIControlStateNormal];
  }
  [self setNeedsLayout];
}
/**
 *  Touch cancel button dragging
 *
 *  @param touches Collection of touch event
 *  @param event   Event touch
 */
- (void)touchesCancelled:(NSSet<UITouch *> *)touches
               withEvent:(UIEvent *)event {
  [self setBackgroundImage:[[UIImage imageNamed:ImageDraggingButtonNormal]
                               resizableImageWithCapInsets:MenuInsetsBackground]
                  forState:UIControlStateNormal];
  [self setNeedsLayout];
}
/**
 *  Touch moved
 *
 *  @param touches Collection of touch event
 *  @param event   Event touch
 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  if (!self.disableDragging) {

    UITouch *touchEnd = [touches anyObject];
    self.pointEndDragg = [touchEnd locationInView:self.window];

    CGFloat xDistance = self.pointEndDragg.x - self.pointBeginDragg.x;
    CGFloat yDistance = self.pointEndDragg.y - self.pointBeginDragg.y;
    CGFloat distance = sqrtf((xDistance * xDistance) + (yDistance * yDistance));

    if (self.pointBeginDragg.y > self.pointEndDragg.y) {

      if ((self.superview.frame.size.height + distance) >
          ([UIScreen mainScreen].bounds.size.height - MaximumDraggingButton)) {

        distance = [UIScreen mainScreen].bounds.size.height -
                   self.superview.frame.size.height - MaximumDraggingButton;
      }
      if ((self.superview.frame.size.height + distance) <=
          ([UIScreen mainScreen].bounds.size.height - MaximumDraggingButton)) {

        CGRect expectRect =
            CGRectMake(self.superview.frame.origin.x,
                       self.superview.frame.origin.y - distance,
                       self.superview.frame.size.width,
                       self.superview.frame.size.height + distance);
        if ([self.delegate respondsToSelector:@selector(didMoveToDistance:
                                                         orirentationIsUp:
                                                                 withView:
                                                                  andRect:)]) {
          [self.delegate didMoveToDistance:distance
                          orirentationIsUp:NO
                                  withView:self.superview
                                   andRect:expectRect];
        }
      }
    } else {
      if ((self.superview.frame.size.height + distance) >
          MinimumDraggingBUtton) {

        distance = MinimumDraggingBUtton - self.superview.frame.size.height;
      }
      if ((self.superview.frame.size.height - distance) >=
          MinimumDraggingBUtton) {

        CGRect expectRect =
            CGRectMake(self.superview.frame.origin.x,
                       self.superview.frame.origin.y + distance,
                       self.superview.frame.size.width,
                       self.superview.frame.size.height - distance);
        if ([self.delegate respondsToSelector:@selector(didMoveToDistance:
                                                         orirentationIsUp:
                                                                 withView:
                                                                  andRect:)]) {

          [self.delegate didMoveToDistance:distance
                          orirentationIsUp:YES
                                  withView:self.superview
                                   andRect:expectRect];
        }
      }
    }
    self.pointBeginDragg = self.pointEndDragg;
  }
}
/**
 *  Touch end
 *  @param touches Collection of touch event
 *  @param event   Event touch
 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

  [self setBackgroundImage:[[UIImage imageNamed:ImageDraggingButtonNormal]
                               resizableImageWithCapInsets:MenuInsetsBackground]
                  forState:UIControlStateNormal];
  [self setNeedsLayout];
}
@end
