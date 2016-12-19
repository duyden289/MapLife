//
//  MenuSearchDraggingButton.h
//  MapLife
//
//  Created by DenNH on 12/19/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuSearchDraggingButtonDelegate <NSObject>

- (void)didMoveToDistance:(CGFloat)distance
         orirentationIsUp:(BOOL)isUp
                 withView:(UIView *)view
                  andRect:(CGRect)rect;

@end

@interface MenuSearchDraggingButton : UIButton

/**
 *  Flag disableDragging
 */
@property(nonatomic, assign) BOOL disableDragging;
/**
 *  Delegate id menu search dragging button
 */
@property(nonatomic, weak) id<MenuSearchDraggingButtonDelegate> delegate;
@end
