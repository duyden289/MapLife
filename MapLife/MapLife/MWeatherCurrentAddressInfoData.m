//
//  MWeatherInfoData.m
//  MapLife
//
//  Created by DenNH on 1/4/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import "MWeatherCurrentAddressInfoData.h"

@implementation MWeatherCurrentAddressInfoData

- (instancetype)initWithTemperature:(NSString *)temperature
                      immageWeather:(NSString *)imageWeatherName
              andDescriptionWeather:(NSString *)descriptionWeather {
  self = [super init];
  if (self != nil) {

    _temperature = temperature;
    _imageNameWeather = imageWeatherName;
    _descriptionWeather = descriptionWeather;
  }
  return self;
}

@end
