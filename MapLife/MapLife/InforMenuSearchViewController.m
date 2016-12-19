//
//  InforMenuSearchViewController.m
//  MapLife
//
//  Created by DenNH on 12/18/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import "InforMenuSearchViewController.h"
#import "UIColor+MapLife.h"

@interface InforMenuSearchViewController ()
/**
 *  Distance label
 */
@property(weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation InforMenuSearchViewController

- (void)viewDidLoad {

  [super viewDidLoad];
  self.distanceLabel.textColor = [UIColor colorWithIndex:MLColorIndex13];
  self.distanceLabel.textAlignment = NSTextAlignmentCenter;
  self.draggingButton.delegate = self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
#pragma mark MenuSearchDraggingButtonDelegate
/**
 *  Did move to distance
 *
 *  @param distance distance move
 *  @param isUp     is Up orirentation
 *  @param view     view move
 *  @param rect     Rect move
 */
- (void)didMoveToDistance:(CGFloat)distance
         orirentationIsUp:(BOOL)isUp
                 withView:(UIView *)view
                  andRect:(CGRect)rect {
  self.distanceMoving = distance;
  self.isUpMoving = isUp;
  if ([self.delegate
          respondsToSelector:@selector(movingContainerScrollWithView:
                                                             andRect:)]) {

    [self.delegate movingContainerScrollWithView:view andRect:rect];
  }
}

@end
