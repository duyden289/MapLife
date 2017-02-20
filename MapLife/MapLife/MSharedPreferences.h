//
//  MSharedPreferences.h
//  MapLife
//
//  Created by DenNH on 1/18/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MSharedPreferences : NSObject
/**
 *  Location object
 */
@property(nonatomic, strong) CLLocation *locationParent;

+(MSharedPreferences *)sharedInstance;

@end
