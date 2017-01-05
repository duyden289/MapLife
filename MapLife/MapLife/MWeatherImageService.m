//
//  MWeatherImageService.m
//  MapLife
//
//  Created by DenNH on 1/4/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import "MWeatherImageService.h"
#import "MServiceBase.h"
#import "MServerURI.h"

@interface MWeatherImageService()<MServiceBaseDelegate>

@property (nonatomic, copy)void(^getDataImage)(NSData *dataImage);

@end

@implementation MWeatherImageService

- (void)startRequestDownloadImageWeather:(NSString *)nameImageFile onCompleteData:(void (^)(NSData *dataImage))completeHandle
{
    self.delegate = self;
    self.getDataImage = completeHandle;
    NSString *urlStringRequest = [NSString stringWithFormat:@"%@%@",[MServerURI sharedInstance].APIWeatherServerImage, nameImageFile];
    [urlStringRequest stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStringRequest]];
    [self startRequest:urlRequest];
}
- (void)requestDidReviceNormalData:(NSData *)responseData
{
    self.getDataImage(responseData);
}
- (void)requestDidReviceErrorFromServer:(NSData *)errorData
{
    
}
@end
