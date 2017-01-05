//
//  MWeatherInfoData.m
//  MapLife
//
//  Created by DenNH on 1/4/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import "MWeatherToAddressInfoData.h"

@implementation MWeatherToAddressInfoData

- (instancetype)initWithTemperature:(NSString *)temperature andImageWeather:(NSString *)imageWeatherName
{
    self = [super init];
    if (self != nil) {
    
        _temperature = temperature;
        _imageNameWeather = imageWeatherName;
        
    }
    return self;
}

@end
