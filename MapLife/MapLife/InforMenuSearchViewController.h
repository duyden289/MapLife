//
//  InforMenuSearchViewController.h
//  MapLife
//
//  Created by DenNH on 12/18/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import "MenuSearchDraggingButton.h"
#import <UIKit/UIKit.h>

extern NSString *const MKeyDistanceName;
extern NSString *const MKeyImageCurrentWeatherName;
extern NSString *const MKeyImageWeatherToAddress;
extern NSString *const MKeyDescriptionCurrentWeather;
extern NSString *const MKeyDescriptionWeatherToAddress;
extern NSString *const MKeyTemperatureCurrentWeather;
extern NSString *const MKeyTemperatureWeatherToAddress;

@protocol InforMenuSearchViewControllerDelegate <NSObject>

- (void)movingContainerScrollWithView:(UIView *)view andRect:(CGRect)rect;

@end

@interface InforMenuSearchViewController
    : UIViewController <MenuSearchDraggingButtonDelegate>

@property(weak, nonatomic) IBOutlet MenuSearchDraggingButton *draggingButton;
@property(nonatomic, weak) id<InforMenuSearchViewControllerDelegate> delegate;
/**
 *  Distance when dragging view
 */
@property(nonatomic, assign) CGFloat distanceMoving;
/**
 *  Orientation moving
 */
@property(nonatomic, assign) BOOL isUpMoving;
@end
