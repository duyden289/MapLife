//
//  MServiceBase.h
//  MapLife
//
//  Created by DenNH on 1/4/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Key API URL Request
 */

extern NSString *const MLatitudeKey;
extern NSString *const MLongitudeKey;
extern NSString *const MAPPIDKeyName;
extern NSString *const MWeatherKeyName;
extern NSString *const MMainWeatherKeyName;
extern NSString *const MTemperatureKeyName;
extern NSString *const MImageKeyName;
extern NSString *const MDescriptionWeatherName;
extern NSString *const MAPIKeyWeather;

@protocol MServiceBaseDelegate <NSObject>

- (void)requestDidReviceNormalData:(NSData *)responseData;
- (void)requestDidReviceErrorFromServer:(NSData *)errorData;

@end

@interface MServiceBase : NSObject

@property(nonatomic, weak) id<MServiceBaseDelegate> delegate;
@property(nonatomic, copy) void (^errorHandleString)(NSString *errorString);

- (void)startRequest:(NSURLRequest *)request;
- (void)cancel;
@end
