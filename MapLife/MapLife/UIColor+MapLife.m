//
//  UIColor+MapLife.m
//  MapLife
//
//  Created by DenNH on 12/19/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import "UIColor+MapLife.h"

@implementation UIColor (MapLife)

/**
 *  Color with index
 *
 *  @param colorIndex Index color
 *
 *  @return Color
 */
+ (UIColor *)colorWithIndex:(MLColorIndex)colorIndex {
  static NSArray *mapLifeColors;
  if (mapLifeColors == nil) {

    mapLifeColors = @[
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0], // color 00
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0], // color 01
      [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0], // color 02
      [UIColor colorWithRed:40.0 / 255.0
                      green:40.0 / 255.0
                       blue:40.0 / 255.0
                      alpha:1.0], // color 03
      [UIColor colorWithRed:185.0 / 255.0
                      green:185.0 / 255.0
                       blue:185.0 / 255.0
                      alpha:1.0], // color 04
      [UIColor colorWithRed:165.0 / 255.0
                      green:165.0 / 255.0
                       blue:165.0 / 255.0
                      alpha:1.0], // color 05
      [UIColor colorWithRed:202.0 / 255.0
                      green:202.0 / 255.0
                       blue:202.0 / 255.0
                      alpha:1.0], // color 06
      [UIColor colorWithRed:78.0 / 255.0
                      green:78.0 / 255.0
                       blue:78.0 / 255.0
                      alpha:1.0], // color 07
      [UIColor colorWithRed:204.0 / 255.0
                      green:0.0 / 255.0
                       blue:51.0 / 255.0
                      alpha:1.0],                              // color 08
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0], // color 09
      [UIColor colorWithRed:255.0 / 255.0
                      green:182.0 / 255.0
                       blue:173.0 / 255.0
                      alpha:1.0], // color 10
      [UIColor colorWithRed:241.0 / 255.0
                      green:178.0 / 255.0
                       blue:190.0 / 255.0
                      alpha:1.0], // color 11
      [UIColor colorWithRed:220.0 / 255.0
                      green:220.0 / 255.0
                       blue:220.0 / 255.0
                      alpha:1.0], // color 12
      [UIColor colorWithRed:128.0 / 255.0
                      green:128.0 / 255.0
                       blue:128.0 / 255.0
                      alpha:1.0], // color 13
      [UIColor colorWithRed:236.0 / 255.0
                      green:236.0 / 255.0
                       blue:236.0 / 255.0
                      alpha:1.0], // color 14
      [UIColor colorWithRed:200.0 / 255.0
                      green:199.0 / 255.0
                       blue:204.0 / 255.0
                      alpha:1.0], // color 15
      [UIColor colorWithRed:220.0 / 255.0
                      green:220.0 / 255.0
                       blue:220.0 / 255.0
                      alpha:1.0], // color 16
      [UIColor colorWithRed:142.0 / 255.0
                      green:142.0 / 255.0
                       blue:147.0 / 255.0
                      alpha:1.0], // color 17
      [UIColor colorWithRed:201.0 / 255.0
                      green:56.0 / 255.0
                       blue:73.0 / 255.0
                      alpha:1.0], // color 18
      [UIColor colorWithRed:224.0 / 255.0
                      green:107.0 / 255.0
                       blue:137.0 / 255.0
                      alpha:1.0], // color 19
      [UIColor colorWithRed:211.0 / 255.0
                      green:37.0 / 255.0
                       blue:80.0 / 255.0
                      alpha:1.0], // color 20
      [UIColor colorWithRed:34.0 / 255.0
                      green:205.0 / 255.0
                       blue:26.0 / 255.0
                      alpha:1.0], // color 22
      [UIColor colorWithRed:0.0 / 255.0
                      green:155.0 / 255.0
                       blue:0.0 / 255.0
                      alpha:1.0], // color 23
      [UIColor colorWithRed:0.0 / 255.0
                      green:250.0 / 255.0
                       blue:255.0 / 255.0
                      alpha:1.0], // color 24
    ];
  }

  if (colorIndex < 0 || (colorIndex > mapLifeColors.count)) {
    colorIndex = 0;
  }
  return mapLifeColors[colorIndex];
}
/**
 *  Color with index
 *
 *  @param colorIndex Index color
 *  @param alpha      Alpha color
 *
 *  @return Color
 */
+ (UIColor *)colorWithIndex:(MLColorIndex)colorIndex withAlpha:(CGFloat)alpha {
  static NSArray *mapLifeColors;
  if (mapLifeColors == nil) {

    mapLifeColors = @[
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:alpha], // color 00
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:alpha], // color 01
      [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:alpha], // color 02
      [UIColor colorWithRed:40.0 / 255.0
                      green:40.0 / 255.0
                       blue:40.0 / 255.0
                      alpha:alpha], // color 03
      [UIColor colorWithRed:185.0 / 255.0
                      green:185.0 / 255.0
                       blue:185.0 / 255.0
                      alpha:alpha], // color 04
      [UIColor colorWithRed:165.0 / 255.0
                      green:165.0 / 255.0
                       blue:165.0 / 255.0
                      alpha:alpha], // color 05
      [UIColor colorWithRed:202.0 / 255.0
                      green:202.0 / 255.0
                       blue:202.0 / 255.0
                      alpha:alpha], // color 06
      [UIColor colorWithRed:78.0 / 255.0
                      green:78.0 / 255.0
                       blue:78.0 / 255.0
                      alpha:alpha], // color 07
      [UIColor colorWithRed:204.0 / 255.0
                      green:0.0 / 255.0
                       blue:51.0 / 255.0
                      alpha:alpha],                            // color 08
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0], // color 09
      [UIColor colorWithRed:255.0 / 255.0
                      green:182.0 / 255.0
                       blue:173.0 / 255.0
                      alpha:alpha], // color 10
      [UIColor colorWithRed:241.0 / 255.0
                      green:178.0 / 255.0
                       blue:190.0 / 255.0
                      alpha:alpha], // color 11
      [UIColor colorWithRed:220.0 / 255.0
                      green:220.0 / 255.0
                       blue:220.0 / 255.0
                      alpha:alpha], // color 12
      [UIColor colorWithRed:128.0 / 255.0
                      green:128.0 / 255.0
                       blue:128.0 / 255.0
                      alpha:alpha], // color 13
      [UIColor colorWithRed:236.0 / 255.0
                      green:236.0 / 255.0
                       blue:236.0 / 255.0
                      alpha:alpha], // color 14
      [UIColor colorWithRed:200.0 / 255.0
                      green:199.0 / 255.0
                       blue:204.0 / 255.0
                      alpha:alpha], // color 15
      [UIColor colorWithRed:220.0 / 255.0
                      green:220.0 / 255.0
                       blue:220.0 / 255.0
                      alpha:alpha], // color 16
      [UIColor colorWithRed:142.0 / 255.0
                      green:142.0 / 255.0
                       blue:147.0 / 255.0
                      alpha:alpha], // color 17
      [UIColor colorWithRed:201.0 / 255.0
                      green:56.0 / 255.0
                       blue:73.0 / 255.0
                      alpha:alpha], // color 18
      [UIColor colorWithRed:224.0 / 255.0
                      green:107.0 / 255.0
                       blue:137.0 / 255.0
                      alpha:alpha], // color 19
      [UIColor colorWithRed:211.0 / 255.0
                      green:37.0 / 255.0
                       blue:80.0 / 255.0
                      alpha:alpha], // color 20
      [UIColor colorWithRed:34.0 / 255.0
                      green:205.0 / 255.0
                       blue:26.0 / 255.0
                      alpha:alpha], // color 22
      [UIColor colorWithRed:0.0 / 255.0
                      green:155.0 / 255.0
                       blue:0.0 / 255.0
                      alpha:alpha], // color 23
      [UIColor colorWithRed:0.0 / 255.0
                      green:250.0 / 255.0
                       blue:255.0 / 255.0
                      alpha:alpha], // color 24
    ];
  }

  if (colorIndex < 0 || (colorIndex > mapLifeColors.count)) {
    colorIndex = 0;
  }
  return mapLifeColors[colorIndex];
}
@end
