//
//  MServerURI.m
//  MapLife
//
//  Created by DenNH on 1/4/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import "MServerURI.h"

NSString *const CONFIG_SERVER = @"Config_Server";
NSString *const MWEARTHER_SERVER_KEY = @"MWEATHER_SERVER";
NSString *const MWEARTHER_SERVER_IMAGE_KEY = @"MWEATHER_SERVER_IMAGE";

@interface MServerURI ()

@property(nonatomic, strong) NSDictionary *serverDictionary;

@end

@implementation MServerURI

+ (MServerURI *)sharedInstance {
  static MServerURI *serverURI;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    serverURI = [[MServerURI alloc] init];

    NSString *pathServer =
        [[NSBundle mainBundle] pathForResource:CONFIG_SERVER ofType:@"plist"];
    serverURI.serverDictionary =
        [[NSDictionary alloc] initWithContentsOfFile:pathServer];

  });
  return serverURI;
}
- (NSString *)APIWeatherServer {
  NSString *appiWeatherServer =
      [self.serverDictionary objectForKey:MWEARTHER_SERVER_KEY];
  return appiWeatherServer;
}
- (NSString *)APIWeatherServerImage {
  return [self.serverDictionary objectForKey:MWEARTHER_SERVER_IMAGE_KEY];
}

@end
