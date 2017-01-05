//
//  MWeatherInfoData.h
//  MapLife
//
//  Created by DenNH on 1/4/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWeatherCurrentAddressInfoData : NSObject

@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *imageNameWeather;

- (instancetype)initWithTemperature:(NSString *)temperature andImageWeather:(NSString *)imageWeatherName;
@end
