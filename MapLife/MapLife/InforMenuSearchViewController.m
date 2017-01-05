//
//  InforMenuSearchViewController.m
//  MapLife
//
//  Created by DenNH on 12/18/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import "Configure.h"
#import "InforMenuSearchViewController.h"
#import "MStringValue.h"
#import "UIColor+MapLife.h"

NSString *const MKeyDistanceName = @"distance";
NSString *const MKeyImageCurrentWeatherName = @"imageCurrentWeather";
NSString *const MKeyImageWeatherToAddress = @"imageWeatherToAddress";
NSString *const MKeyDescriptionCurrentWeather = @"descriptionCurrentWeather";
NSString *const MKeyDescriptionWeatherToAddress =
    @"descriptionWeatherToAddress";
NSString *const MKeyTemperatureCurrentWeather = @"temperatureCurrentWeather";
NSString *const MKeyTemperatureWeatherToAddress =
    @"temperatureWeatherToAddress";

@interface InforMenuSearchViewController ()
/**
 *  Distance label
 */
@property(weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property(weak, nonatomic) IBOutlet UILabel *UnitsDistanceLabel;
@property(weak, nonatomic) IBOutlet UILabel *descriptionWeatherToAddress;
@property(weak, nonatomic) IBOutlet UIImageView *imageWeatherToAddress;
@property(weak, nonatomic) IBOutlet UIImageView *imageWeatherCurrentAddress;
@property(weak, nonatomic) IBOutlet UILabel *descriptionWeatherCurrentAddress;
@property(weak, nonatomic) IBOutlet UILabel *temperatureCurrentWeather;
@property(weak, nonatomic) IBOutlet UILabel *temperatureWeatherToAddress;

@end

@implementation InforMenuSearchViewController

- (void)viewDidLoad {

  [super viewDidLoad];

  self.draggingButton.delegate = self;
  [self configureUI];
  [self registerNotification];
}
/**
 * Configure UI display
 */
- (void)configureUI {
  self.distanceLabel.textColor = [UIColor colorWithIndex:MLColorIndex13];
  self.distanceLabel.textAlignment = NSTextAlignmentRight;
  self.distanceLabel.font = [UIFont boldSystemFontOfSize:30.0];

  self.UnitsDistanceLabel.textColor = [UIColor colorWithIndex:MLColorIndex08];
  self.UnitsDistanceLabel.textAlignment = NSTextAlignmentCenter;
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

- (void)displayAddressDistance:(double)distance
       withImageCurrentWeather:(NSData *)dataImageCurrentWeather
     temperatureCurrentWeather:(NSString *)temperatureCurrentWeather
     descriptionCurrentWeather:(NSString *)descriptionCurrentWeather
        imageWeatherToAddresss:(NSData *)dataImageWeatherToAddress
   temperatureWeatherToAddress:(NSString *)temperatureWeatherToAddress
   descriptionWeatherToAddress:(NSString *)descriptionWeatherToAddress {

  BOOL isMetric = [[[NSLocale currentLocale]
      objectForKey:NSLocaleUsesMetricSystem] boolValue];

  NSString *format;

  if (isMetric) {
    if (distance < METERS_CUTOFF) {
      self.UnitsDistanceLabel.text = @"Meters";
      format = @"%@";
    } else {
      self.UnitsDistanceLabel.text = @"Km";
      format = @"%@";
      distance = distance / 1000;
    }
  } else { // assume Imperial / U.S.
    distance = distance * METERS_TO_FEET;
    if (distance < FEET_CUTOFF) {
      self.UnitsDistanceLabel.text = @"Feet";
      format = @"%@";
    } else {
      self.UnitsDistanceLabel.text = @"Miles";
      format = @"%@";
      distance = distance / FEET_IN_MILES;
    }
  }

  // Update information search
  self.distanceLabel.text =
      [NSString stringWithFormat:format, [self stringWithDouble:distance]];
  self.imageWeatherCurrentAddress.image =
      [UIImage imageWithData:dataImageCurrentWeather];
  self.imageWeatherToAddress.image =
      [UIImage imageWithData:dataImageWeatherToAddress];
  self.descriptionWeatherCurrentAddress.text =
      [descriptionCurrentWeather capitalizedString];
  self.descriptionWeatherToAddress.text =
      [descriptionWeatherToAddress capitalizedString];
    
    
  NSString *tempCurrentWeather =
      [NSString stringWithFormat:@"%@%@", [NSString stringWithFormat:@"%.01f",[temperatureCurrentWeather doubleValue] - 273.15], @"°C"];
  NSString *tempWeatherToAddress =
      [NSString stringWithFormat:@"%@%@", [NSString stringWithFormat:@"%.01f",[temperatureWeatherToAddress doubleValue] - 273.15], @"°C"];
  self.temperatureCurrentWeather.text = tempCurrentWeather;
  self.temperatureWeatherToAddress.text = tempWeatherToAddress;
    // Set font
    self.temperatureCurrentWeather.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    self.temperatureWeatherToAddress.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    // Set Color
    self.temperatureCurrentWeather.textColor = [UIColor colorWithIndex:MLColorIndex08];
    self.temperatureWeatherToAddress.textColor = [UIColor colorWithIndex:MLColorIndex08];
}
// Return a string of the number to one decimal place and with commas & periods
// based on the locale.
- (NSString *)stringWithDouble:(double)value {

  NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
  [numberFormatter setLocale:[NSLocale currentLocale]];
  [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
  [numberFormatter setMaximumFractionDigits:2];
  return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
}

/**
 * Register notification
 */
- (void)registerNotification {

  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(reviceDistanceWithNotification:)
             name:MNotificationInformationName
           object:nil];
}
/**
 *  Revice distance
 *
 *  @param notification Notification object
 */
- (void)reviceDistanceWithNotification:(NSNotification *)notification {

  NSDictionary *distanceDictionary = notification.userInfo;
  [self displayAddressDistance:[[distanceDictionary
                                   objectForKey:MKeyDistanceName] doubleValue]
          withImageCurrentWeather:[distanceDictionary
                                      objectForKey:MKeyImageCurrentWeatherName]
        temperatureCurrentWeather:
            [distanceDictionary objectForKey:MKeyTemperatureCurrentWeather]
        descriptionCurrentWeather:
            [distanceDictionary objectForKey:MKeyDescriptionCurrentWeather]
           imageWeatherToAddresss:[distanceDictionary
                                      objectForKey:MKeyImageWeatherToAddress]
      temperatureWeatherToAddress:
          [distanceDictionary objectForKey:MKeyTemperatureWeatherToAddress]
      descriptionWeatherToAddress:
          [distanceDictionary objectForKey:MKeyDescriptionWeatherToAddress]];
}
/**
 *  Dealoc method
 */
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
