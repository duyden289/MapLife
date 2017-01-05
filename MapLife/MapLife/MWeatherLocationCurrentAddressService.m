//
//  MWeatherCurrentAddressService.m
//  MapLife
//
//  Created by DenNH on 1/4/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import "MServerURI.h"
#import "MServiceBase.h"
#import "MWeatherCurrentAddressInfoData.h"
#import "MWeatherLocationCurrentAddressService.h"

@interface MWeatherLocationCurrentAddressService () <MServiceBaseDelegate>

@property(nonatomic, copy) void (^getWeatherList)(NSArray *listWeather);

@end
@implementation MWeatherLocationCurrentAddressService

- (void)
startRequestOnCompleteWithLatitude:(CGFloat)latitude
                      andLongitude:(CGFloat)lonitude
                     successHanlde:(void (^)(NSArray *weatherList))successHandle
                           onError:
                               (void (^)(NSString *errorString))errorHanlde {
  self.errorHandleString = errorHanlde;
  self.delegate = self;
  self.getWeatherList = successHandle;

  NSString *urlStringRequest =
      [NSString stringWithFormat:@"%@%@%f%@%@%f%@%@%@",
                                 [MServerURI sharedInstance].APIWeatherServer,
                                 MLatitudeKey, latitude, @"&", MLongitudeKey,
                                 lonitude, @"&", MAPPIDKeyName, MAPIKeyWeather];
  NSURLRequest *urlRequest =
      [NSURLRequest requestWithURL:[NSURL URLWithString:urlStringRequest]];
  [self startRequest:urlRequest];
}
#pragma mark MServiceBaseDelegate

- (void)requestDidReviceNormalData:(NSData *)responseData {
  NSError *jsonError = nil;

  NSDictionary *jsonDictionary =
      [NSJSONSerialization JSONObjectWithData:responseData
                                      options:NSJSONReadingMutableContainers
                                        error:&jsonError];

  if (jsonError != nil || jsonDictionary == nil) {

    dispatch_async(dispatch_get_main_queue(), ^{

      // Show error request
      self.errorHandleString(@"");

    });
  }
  NSDictionary *dictionaryImageWeather =
      [jsonDictionary objectForKey:MWeatherKeyName];
  NSDictionary *dictionaryTemperatureWeather =
      [jsonDictionary objectForKey:MMainWeatherKeyName];

  NSString *temperature = dictionaryTemperatureWeather[MTemperatureKeyName];
  NSString *nameImageWeather = nil;
  NSString *descriptionWeather = nil;

  for (NSDictionary *weather in dictionaryImageWeather) {
    nameImageWeather = weather[MImageKeyName];
    descriptionWeather = weather[MDescriptionWeatherName];
  }
  NSMutableArray *weathers = [NSMutableArray array];
  if (temperature != nil && nameImageWeather != nil) {

    MWeatherCurrentAddressInfoData *weatherInfoData =
        [[MWeatherCurrentAddressInfoData alloc]
              initWithTemperature:temperature
                    immageWeather:nameImageWeather
            andDescriptionWeather:descriptionWeather];

    [weathers addObject:weatherInfoData];
  }

  dispatch_async(dispatch_get_main_queue(), ^{

    self.getWeatherList(weathers);

  });
}
- (void)requestDidReviceErrorFromServer:(NSData *)errorData {
}

@end
