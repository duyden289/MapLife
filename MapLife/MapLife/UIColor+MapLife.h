//
//  UIColor+MapLife.h
//  MapLife
//
//  Created by DenNH on 12/19/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import <UIKit/UIKit.h>
// Enum Color
typedef NS_ENUM(NSInteger, MLColorIndex) {

  MLColorIndex00,
  MLColorIndex01,
  MLColorIndex02,
  MLColorIndex03,
  MLColorIndex04,
  MLColorIndex05,
  MLColorIndex06,
  MLColorIndex07,
  MLColorIndex08,
  MLColorIndex09,
  MLColorIndex10,
  MLColorIndex11,
  MLColorIndex12,
  MLColorIndex13,
  MLColorIndex14,
  MLColorIndex15,
  MLColorIndex16,
  MLColorIndex17,
  MLColorIndex18,
  MLColorIndex19,
  MLColorIndex20,
  MLColorIndex21,
  MLColorIndex22,
  MLColorIndex23,
  MLColorIndex24
};

@interface UIColor (MapLife)
/**
 *  Color with index
 *
 *  @param colorIndex Index color
 *
 *  @return Color
 */
+ (UIColor *)colorWithIndex:(MLColorIndex)colorIndex;
/**
 *  Color with index
 *
 *  @param colorIndex Index color
 *  @param alpha      Alpha color
 *
 *  @return Color
 */
+ (UIColor *)colorWithIndex:(MLColorIndex)colorIndex withAlpha:(CGFloat)alpha;
@end
