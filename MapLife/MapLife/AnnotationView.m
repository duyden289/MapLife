//
//  AnnotationView.m
//  MapLife
//
//  Created by DenNH on 11/20/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import "AnnotationView.h"

@interface AnnotationView ()

@end

@implementation AnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation
                   reuseIdentifier:(NSString *)reuseIdentifier
                           pinView:(UIView *)pinView
                       calloutView:(UIView *)calloutView {

  self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
  if (self) {
    self.clipsToBounds = NO;
    self.canShowCallout = NO;
    self.pinView = pinView;
    self.calloutView = calloutView;
    //    self.calloutView.hidden = YES;
    // Add subView
    [self addSubview:self.pinView];
    [self addSubview:self.calloutView];
    // Calculate frame view
    self.frame = [self calculateFrame];
    [self positionSubView];
  }
  return self;
}
- (CGRect)calculateFrame {

  return self.pinView.bounds;
}

- (void)positionSubView {
  //  self.pinView.center = self.center;
  CGRect frame = self.calloutView.frame;
  frame.origin.y = -frame.size.height;
  frame.origin.x = (self.frame.size.width - frame.size.width) / 2.0;
  self.calloutView.frame = frame;
}
- (void)showCalloutView {
  self.calloutView.transform = CGAffineTransformMakeScale(0.025, 0.025);
  //    self.calloutView.hidden = NO;
  [UIView animateWithDuration:0.25
                   animations:^{
                     self.calloutView.transform =
                         CGAffineTransformMakeScale(1.0, 1.0);
                   }];
}
#pragma mark PinView
- (void)setPinView:(UIView *)pinView {

  [_pinView removeFromSuperview];
  _pinView = pinView;
  [self addSubview:_pinView];
  self.frame = [self calculateFrame];
  //  self.pinView.center = self.center;
}
#pragma mark CalloutView
- (void)setCalloutView:(UIView *)calloutView {

  [_calloutView removeFromSuperview];
  _calloutView = calloutView;
  [self addSubview:_calloutView];
  [self positionSubView];
}

@end
