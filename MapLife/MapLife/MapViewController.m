//
//  ViewController.m
//  MapLife
//
//  Created by DenNH on 11/20/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import "Annotation.h"
#import "AnnotationView.h"
#import "MSearchAddressViewController.h"
#import "MapViewController.h"
#import "ViewInfo.h"
#import <MapKit/MapKit.h>

/**
 *  Image name pin map
 */
NSString *const MKPinmapImage = @"pinmap";
NSString *const MSegueSearch = @"SegueSearch";

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate,
                                 MSearchAddressViewControllerDelegate>
/**
 *  Mapview
 */
@property(weak, nonatomic) IBOutlet MKMapView *mapLifeView;
/**
 *  Location object
 */
@property(nonatomic, strong) CLLocation *location;
/**
 *  CLLocation manager object
 */
@property(nonatomic, strong) CLLocationManager *locationManager;
/**
 *  Annotation object
 */
@property(nonatomic, strong) Annotation *annotation;
/**
 *  Viewinfo object
 */
@property(nonatomic, strong) ViewInfo *viewInfo;
/**
 *  Has location
 */
@property(nonatomic, assign) BOOL hasLocation;
/**
 *  Geocoder object
 */
@property(nonatomic, strong) CLGeocoder *geocoder;
/**
 *  Place mark
 */
@property(nonatomic, strong) CLPlacemark *placeMark;
/**
 *  Address user
 */
@property(nonatomic, strong) NSString *addressUser;
/**
 *  Polyline over lay
 */
@property(nonatomic, strong) MKPolyline *routeOveray;
/**
 *  Route map location
 */
@property(nonatomic, strong) MKRoute *route;

@end

@implementation MapViewController

/**
 *  <#Description#>
 */
- (void)viewDidLoad {
  [super viewDidLoad];

  // Set map view delegate
  self.mapLifeView.delegate = self;
  // Configua location manager
  self.locationManager = [[CLLocationManager alloc] init];
  [self.locationManager requestAlwaysAuthorization];
  self.locationManager.delegate = self;
  self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  //  [self.locationManager startUpdatingLocation];
  //  self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
  [self.locationManager startUpdatingLocation];

  self.geocoder = [[CLGeocoder alloc] init];
}

#pragma Mark MapviewDelegate
/**
 *  <#Description#>
 *
 *  @param mapView    <#mapView description#>
 *  @param annotation <#annotation description#>
 *
 *  @return <#return value description#>
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {

  if ([annotation isKindOfClass:[MKUserLocation class]]) {
    return nil;
  }
  if ([annotation isKindOfClass:[Annotation class]]) {

    UIImageView *pinView = nil;
    UIView *calloutView = nil;

    AnnotationView *annotationView = (AnnotationView *)[mapView
        dequeueReusableAnnotationViewWithIdentifier:
            NSStringFromClass([AnnotationView class])];
    if (!annotationView) {

      pinView = [[UIImageView alloc]
          initWithImage:[UIImage imageNamed:MKPinmapImage]];

      self.viewInfo =
          (ViewInfo *)[[[NSBundle mainBundle] loadNibNamed:@"ViewInfo"
                                                     owner:self
                                                   options:nil] firstObject];
      [self.viewInfo loadInfoAddress:self.addressUser];
      calloutView = self.viewInfo;
      annotationView = [[AnnotationView alloc]
          initWithAnnotation:annotation
             reuseIdentifier:NSStringFromClass([AnnotationView class])
                     pinView:pinView
                 calloutView:calloutView];

    } else {
      pinView = (UIImageView *)annotationView.pinView;
      pinView.image = [UIImage imageNamed:MKPinmapImage];
    }
    return annotationView;
  }
  return nil;
  // If it's the user location, just return nil.
  //  if ([annotation isKindOfClass:[MKUserLocation class]])
  //    return nil;
  //  // Handle any custom annotations.
  //  if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
  //    // Try to dequeue an existing pin view first.
  //    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[self.mapLifeView
  //        dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
  //    if (!pinView) {
  //      // If an existing pin view was not available, create one.
  //      pinView = [[MKPinAnnotationView alloc]
  //          initWithAnnotation:annotation
  //             reuseIdentifier:@"CustomPinAnnotationView"];
  //      pinView.canShowCallout = YES;
  //        pinView.hidden = YES;
  //    } else {
  //      pinView.annotation = annotation;
  //        pinView.hidden = YES;
  //    }
  //    return pinView;
  //  }
  //  return nil;
}

- (void)mapView:(MKMapView *)mapView
    didSelectAnnotationView:(MKAnnotationView *)view {
  if ([view isKindOfClass:[AnnotationView class]]) {

    [(AnnotationView *)view showCalloutView];
    view.layer.zPosition = 0;
  }
}

- (void)mapView:(MKMapView *)mapView
    didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
  self.mapLifeView.showsUserLocation = NO;
}
#pragma mark CLLocationManagerDelegate
/**
 *  <#Description#>
 *
 *  @param manager   <#manager description#>
 *  @param locations <#locations description#>
 */
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
  CLLocation *currentLocation = locations[0];
  self.location = currentLocation;

  if (!self.hasLocation) {
    self.hasLocation = YES;
    if (currentLocation != nil) {

      self.annotation = [Annotation new];
      self.annotation.coordinate =
          CLLocationCoordinate2DMake(currentLocation.coordinate.latitude,
                                     currentLocation.coordinate.longitude);
    }
    [self.geocoder
        reverseGeocodeLocation:currentLocation
             completionHandler:^(NSArray<CLPlacemark *> *_Nullable placemarks,
                                 NSError *_Nullable error) {

               if (error == nil && [placemarks count] > 0) {

                 self.placeMark = [placemarks lastObject];
                 self.addressUser = [NSString
                     stringWithFormat:@"%@, %@, %@", self.placeMark.name,
                                      self.placeMark.administrativeArea,
                                      self.placeMark.country];

                 [self.mapLifeView addAnnotation:self.annotation];
                 [self.mapLifeView
                     setRegion:MKCoordinateRegionMakeWithDistance(
                                   self.annotation.coordinate, 1000, 1000)];
                 [self.mapLifeView selectAnnotation:self.annotation
                                           animated:YES];
               }

             }];
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

  if ([segue.identifier isEqualToString:MSegueSearch]) {

    MSearchAddressViewController *searchViewController =
        segue.destinationViewController;
    searchViewController.delegate = self;
  }
}

#pragma mark MSearchViewControllerDelegate
- (void)searchAddressFromLocationCoordinate:
            (CLLocationCoordinate2D)locationCoordinateFromAddress
                locationCoordinateToAddress:
                    (CLLocationCoordinate2D)locationCoordinateToAddress {

  MKDirectionsRequest *directionRequest = [MKDirectionsRequest new];
  MKPlacemark *fromPlacemark;
  if (lroundf(locationCoordinateFromAddress.latitude) == 0 &&
      lroundf(locationCoordinateFromAddress.longitude) == 0) {

    fromPlacemark =
        [[MKPlacemark alloc] initWithCoordinate:self.location.coordinate
                              addressDictionary:nil];
  } else {
    fromPlacemark =
        [[MKPlacemark alloc] initWithCoordinate:locationCoordinateFromAddress
                              addressDictionary:nil];
  }
  MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:fromPlacemark];

  MKPlacemark *toPlacemark =
      [[MKPlacemark alloc] initWithCoordinate:locationCoordinateToAddress
                            addressDictionary:nil];
  MKMapItem *toItem = [[MKMapItem alloc] initWithPlacemark:toPlacemark];

  [directionRequest setSource:fromItem];
  [directionRequest setDestination:toItem];

  MKDirections *directions =
      [[MKDirections alloc] initWithRequest:directionRequest];
  [directions calculateDirectionsWithCompletionHandler:^(
                  MKDirectionsResponse *_Nullable response,
                  NSError *_Nullable error) {

    if (error) {
      return;
    }
    self.route = [response.routes firstObject];
    NSArray *arrRoutes = [response routes];
    [arrRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx,
                                            BOOL *stop) {
      MKRoute *rout = obj;

      NSLog(@"Rout Name : %@", rout.name);
      NSLog(@"Total Distance (in Meters) :%f", rout.distance);
      NSArray *steps = [rout steps];
      NSLog(@"Total Steps : %lu", (unsigned long)[steps count]);
      [steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"Rout Instruction : %@", [obj instructions]);
        NSLog(@"Rout Distance : %f", [obj distance]);
      }];
    }];

    [self plotOnMap:self.route];

  }];
}
#pragma mark Unitily method
- (void)plotOnMap:(MKRoute *)route {
  if (self.routeOveray) {
    [self.mapLifeView removeOverlay:self.routeOveray];
  }
  self.routeOveray = route.polyline;
  [self.mapLifeView setVisibleMapRect:[self.routeOveray boundingMapRect]];
  [self.mapLifeView addOverlay:self.routeOveray];
}

#pragma mark MPMapViewDelegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay {
  MKPolylineRenderer *polylineRenderer =
      [[MKPolylineRenderer alloc] initWithPolyline:overlay];
  polylineRenderer.strokeColor = [UIColor redColor];
  polylineRenderer.lineWidth = 6.0;
  return polylineRenderer;
}
@end
