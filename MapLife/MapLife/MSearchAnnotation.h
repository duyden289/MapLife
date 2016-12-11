//
//  MSearchAnnotation.h
//  MapLife
//
//  Created by DenNH on 12/11/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MSearchAnnotation : NSObject <MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
