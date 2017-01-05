//
//  MServerURI.h
//  MapLife
//
//  Created by DenNH on 1/4/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MServerURI : NSObject

+(MServerURI *)sharedInstance;
- (NSString *)APIWeatherServer;
- (NSString *)APIWeatherServerImage;

@end
