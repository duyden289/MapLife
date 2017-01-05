//
//  MWeatherInfoData.h
//  MapLife
//
//  Created by DenNH on 1/4/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWeatherToAddressInfoData : NSObject

@property(nonatomic, strong) NSString *temperature;
@property(nonatomic, strong) NSString *imageNameWeather;
@property(nonatomic, strong) NSString *descriptionWeather;

- (instancetype)initWithTemperature:(NSString *)temperature
                      immageWeather:(NSString *)imageWeatherName
              andDescriptionWeather:(NSString *)descriptionWeather;
@end
