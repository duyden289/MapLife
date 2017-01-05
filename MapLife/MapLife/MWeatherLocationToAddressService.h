//
//  MWeatherCurrentAddressService.h
//  MapLife
//
//  Created by DenNH on 1/4/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import "MServiceBase.h"
#import <UIKit/UIKit.h>

@interface MWeatherLocationToAddressService : MServiceBase

- (void)
startRequestOnCompleteWithLatitude:(CGFloat)latitude
                      andLongitude:(CGFloat)lonitude
                     successHanlde:(void (^)(NSArray *weatherList))successHandle
                           onError:(void (^)(NSString *errorString))errorHanlde;

@end
