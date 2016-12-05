//
//  Annotation.h
//  MapLife
//
//  Created by DenNH on 11/20/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
