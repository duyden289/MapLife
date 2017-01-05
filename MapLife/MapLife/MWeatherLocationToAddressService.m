//
//  MWeatherCurrentAddressService.m
//  MapLife
//
//  Created by DenNH on 1/4/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import "MWeatherLocationToAddressService.h"
#import "MServiceBase.h"
#import "MServerURI.h"
#import "MWeatherToAddressInfoData.h"

@interface MWeatherLocationToAddressService()<MServiceBaseDelegate>

@property (nonatomic, copy)void(^getWeatherToAddressList)(NSArray *listWeather);

@end
@implementation MWeatherLocationToAddressService

- (void)startRequestOnCompleteWithLatitude:(CGFloat)latitude andLongitude:(CGFloat)lonitude successHanlde:(void (^)(NSArray * weatherList))successHandle onError:(void (^)(NSString *errorString))errorHanlde
{
    self.errorHandleString = errorHanlde;
    self.delegate = self;
    self.getWeatherToAddressList = successHandle;
    
    NSString *urlStringRequest = [NSString stringWithFormat:@"%@%@%f%@%@%f%@%@%@", [MServerURI sharedInstance].APIWeatherServer, MLatitudeKey,latitude,@"&",MLongitudeKey,lonitude,@"&",MAPPIDKeyName, MAPIKeyWeather];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStringRequest]];
    [self startRequest:urlRequest];
    
}
#pragma mark MServiceBaseDelegate

- (void)requestDidReviceNormalData:(NSData *)responseData
{
    NSError *jsonError = nil;
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonError];
    
    if (jsonError != nil || jsonDictionary == nil) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            // Show error request
            self.errorHandleString (@"");
            
        });
    }
    NSDictionary *dictionaryImageWeather = [jsonDictionary objectForKey:MWeatherKeyName];
    NSDictionary *dictionaryTemperatureWeather = [jsonDictionary objectForKey:MMainWeatherKeyName];
    
    NSString *temperature = dictionaryTemperatureWeather[MTemperatureKeyName];
    NSString *nameWeather = nil;
    
    for (NSDictionary *weather in dictionaryImageWeather) {
        nameWeather = weather[MImageKeyName];
    }
    NSMutableArray *weathers = [NSMutableArray array];
    if (temperature != nil && nameWeather != nil) {
        
        MWeatherToAddressInfoData *weatherInfoData = [[MWeatherToAddressInfoData alloc] initWithTemperature:temperature andImageWeather:nameWeather];
        [weathers addObject:weatherInfoData];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.getWeatherToAddressList(weathers);
        
    });
    
}
-(void)requestDidReviceErrorFromServer:(NSData *)errorData
{
    
}

@end
