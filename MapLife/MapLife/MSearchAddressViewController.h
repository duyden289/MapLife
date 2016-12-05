//
//  MSearchAddressViewController.h
//  MapLife
//
//  Created by DenNH on 11/24/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import "MBaseViewController.h"
#import <MapKit/MapKit.h>
extern NSString *const MCurrentAddressName;

@protocol MSearchAddressViewControllerDelegate <NSObject>

@required

- (void)searchAddressFromLocationCoordinate:
            (CLLocationCoordinate2D)locationCoordinateFromAddress
                locationCoordinateToAddress:
                    (CLLocationCoordinate2D)locationCoordinateToAddress;

@end

@interface MSearchAddressViewController : MBaseViewController

@property(nonatomic, weak) id<MSearchAddressViewControllerDelegate> delegate;
@property(nonatomic, strong) MKMapView *mapView;

@end
