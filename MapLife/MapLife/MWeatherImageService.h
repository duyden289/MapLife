//
//  MWeatherImageService.h
//  MapLife
//
//  Created by DenNH on 1/4/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import "MServiceBase.h"

@interface MWeatherImageService : MServiceBase

- (void)startRequestDownloadImageWeather:(NSString *)nameImageFile onCompleteData:(void (^)(NSData *dataImage))completeHandle;

@end
