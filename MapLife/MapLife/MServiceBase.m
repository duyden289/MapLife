//
//  MServiceBase.m
//  MapLife
//
//  Created by DenNH on 1/4/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import "MServiceBase.h"

typedef NS_ENUM(NSInteger, MServiceHTTPBase) { MServiceHTTPBaseOK = 200 };
/**
 * Key API URL Request
 */

NSString *const MLatitudeKey = @"lat=";
NSString *const MLongitudeKey = @"lon=";
NSString *const MAPPIDKeyName = @"appid=";
NSString *const MWeatherKeyName = @"weather";
NSString *const MMainWeatherKeyName = @"main";
NSString *const MTemperatureKeyName = @"temp";
NSString *const MImageKeyName = @"icon";
NSString *const MDescriptionWeatherName = @"description";
NSString *const MAPIKeyWeather = @"eb536a83d9db39482b3fac70e8e56723";

@interface MServiceBase () <NSURLSessionDelegate>

@property(nonatomic, strong) NSURLSessionDataTask *urlSessionDataTask;

@end

@implementation MServiceBase

- (void)startRequest:(NSURLRequest *)request {

  NSURLSessionConfiguration *urlSessionConfiguration =
      [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *session =
      [NSURLSession sessionWithConfiguration:urlSessionConfiguration
                                    delegate:self
                               delegateQueue:[NSOperationQueue mainQueue]];
  self.urlSessionDataTask = [session
      dataTaskWithRequest:request
        completionHandler:^(NSData *_Nullable data,
                            NSURLResponse *_Nullable response,
                            NSError *_Nullable error) {

          [self requestCompleteWithData:data response:response error:error];

        }];
  [self.urlSessionDataTask resume];
}
- (void)requestCompleteWithData:(NSData *)data
                       response:(NSURLResponse *)response
                          error:(NSError *)error {
  if (error != nil) {

  } else {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == MServiceHTTPBaseOK) {

      if ([self.delegate
              respondsToSelector:@selector(requestDidReviceNormalData:)]) {

        [self.delegate requestDidReviceNormalData:data];
      }
    } else {
      if ([self.delegate
              respondsToSelector:@selector(requestDidReviceErrorFromServer:)]) {

        [self.delegate requestDidReviceErrorFromServer:data];
      }
    }
  }
}
- (void)cancel {
  self.delegate = nil;
  if (self.urlSessionDataTask != nil) {

    [self.urlSessionDataTask cancel];
    self.urlSessionDataTask = nil;
  }
}

@end
