//
//  ViewController.m
//  MapLife
//
//  Created by DenNH on 11/20/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import "Annotation.h"
#import "AnnotationView.h"
#import "InforMenuSearchViewController.h"
#import "MSearchAddressViewController.h"
#import "MSearchAnnotation.h"
#import "MapViewController.h"
#import "SearchAnnotationView.h"
#import "ViewInfo.h"
#import <MapKit/MapKit.h>
/**
 *  Image name pin map
 */
NSString *const MKPinmapImage = @"pinmap";
NSString *const MKPinMapSearchImage = @"iconToAddress";
NSString *const MSegueSearch = @"SegueSearch";
/**
 *  Storyboard infor menu search view controller
 */
NSString *const StoryboardInforMenuSearchViewController =
    @"SBInforMenuSearchViewController";

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate,
                                 MSearchAddressViewControllerDelegate,
                                 InforMenuSearchViewControllerDelegate>
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
 *  Annotation object
 */
@property(nonatomic, strong) MSearchAnnotation *searchAnnotation;
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
/**
 *  Infor menu search
 */
@property(nonatomic, strong) InforMenuSearchViewController *infoMenuSearch;
/**
 *  Height constraint
 */
@property (strong, nonatomic) NSLayoutConstraint *heightConstraintView;
@property (nonatomic, strong) NSMutableArray *arrayAnnotationSearchs;
@property (nonatomic, strong) SearchAnnotationView *searchannotationView;

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
    self.arrayAnnotationSearchs = [[NSMutableArray alloc] init];
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
  if ([annotation isKindOfClass:[MSearchAnnotation class]]) {

    UIImageView *pinView = nil;
      UIView *calloutView = nil;
    self.searchannotationView = nil;
    if (self.searchannotationView == nil) {

        self.searchannotationView =
        (SearchAnnotationView *)[mapView
                                 dequeueReusableAnnotationViewWithIdentifier:
                                 NSStringFromClass([SearchAnnotationView class])];
      pinView = [[UIImageView alloc]
          initWithImage:[UIImage imageNamed:MKPinMapSearchImage]];

      self.viewInfo =
          (ViewInfo *)[[[NSBundle mainBundle] loadNibNamed:@"ViewInfo"
                                                     owner:self
                                                   options:nil] firstObject];
      [self.viewInfo loadInfoAddress:self.addressUser];
      calloutView = self.viewInfo;
      self.searchannotationView = [[SearchAnnotationView alloc]
          initWithAnnotation:annotation
             reuseIdentifier:NSStringFromClass([SearchAnnotationView class])
                     pinView:pinView
                 calloutView:calloutView];

    } else {
      pinView = (UIImageView *)self.searchannotationView.pinView;
      pinView.image = [UIImage imageNamed:MKPinmapImage];
    }
    return self.searchannotationView;
  }
  return nil;
}
- (void)mapView:(MKMapView *)mapView
    didSelectAnnotationView:(MKAnnotationView *)view {
  if ([view isKindOfClass:[AnnotationView class]]) {

    [(AnnotationView *)view showCalloutView];
    view.layer.zPosition = 0;
  }
  if ([view isKindOfClass:[SearchAnnotationView class]]) {

    [(SearchAnnotationView *)view showCalloutView];
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
      // Setup annotation
      [self setupAnnotation:self.annotation location:currentLocation];
    }
  }
}
- (void)setupAnnotation:(id<MKAnnotation>)annotation
               location:(CLLocation *)currentLocation {
  annotation.coordinate =
      CLLocationCoordinate2DMake(currentLocation.coordinate.latitude,
                                 currentLocation.coordinate.longitude);

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
                 if ([annotation isKindOfClass:[MSearchAnnotation class]]) {
                     
                     [self.arrayAnnotationSearchs addObject:annotation];
                     MSearchAnnotation *lastSearchAnnotation = (MSearchAnnotation *)[self.arrayAnnotationSearchs lastObject];
                     for (MSearchAnnotation *searchAnnotationItem in self.arrayAnnotationSearchs) {
                         
                         if (searchAnnotationItem != lastSearchAnnotation) {
                             
                             [self.mapLifeView removeAnnotation:searchAnnotationItem];
                         }
                     }
                     [self.mapLifeView addAnnotation:lastSearchAnnotation];
                     
                 }
               else
               {
                   [self.mapLifeView addAnnotation:annotation];
               }
               [self.mapLifeView
                   setRegion:MKCoordinateRegionMakeWithDistance(
                                 annotation.coordinate, 1000, 1000)];
               [self.mapLifeView selectAnnotation:annotation animated:YES];
             }

           }];
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
    self.searchAnnotation = [MSearchAnnotation new];
    CLLocation *locationToAddress = [[CLLocation alloc]
        initWithLatitude:locationCoordinateToAddress.latitude
               longitude:locationCoordinateToAddress.longitude];
    // Setup annotation
    [self setupAnnotation:self.searchAnnotation location:locationToAddress];

    [self plotOnMap:self.route];
      
      self.infoMenuSearch = nil;
    // Add search view info
    [self addSearchViewInfo];

  }];
}
- (void)addSearchViewInfo {

  // Setup infor menu search
    if (self.infoMenuSearch == nil) {
        
        self.infoMenuSearch =
        [self.storyboard instantiateViewControllerWithIdentifier:
         StoryboardInforMenuSearchViewController];
    }
    
  self.infoMenuSearch.delegate = self;
  // Add infor search to view
  [self addChildViewController:self.infoMenuSearch];
  [self.view addSubview:self.infoMenuSearch.view];
  [self.infoMenuSearch didMoveToParentViewController:self];

  UIView *subView = self.infoMenuSearch.view;
  UIView *parent = self.view;
  subView.translatesAutoresizingMaskIntoConstraints = NO;

  // Trailing
  NSLayoutConstraint *rightConstraintView =
      [NSLayoutConstraint constraintWithItem:parent
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:subView
                                   attribute:NSLayoutAttributeTrailing
                                  multiplier:1.0f
                                    constant:0.0];

  // Leading
  NSLayoutConstraint *leftConstraintView =
      [NSLayoutConstraint constraintWithItem:subView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:parent
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1.0f
                                    constant:0.0];

  // Bottom
  NSLayoutConstraint *bottom =
      [NSLayoutConstraint constraintWithItem:parent
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:subView
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1.0f
                                    constant:0.0];

  // Height to be fixed for SubView same as AdHeight
  self.heightConstraintView =
      [NSLayoutConstraint constraintWithItem:subView
                                   attribute:NSLayoutAttributeHeight
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:nil
                                   attribute:(NSLayoutAttribute)0
                                  multiplier:1.0f
                                    constant:150.0];

  // Add constraint of the View to the Card View
  [parent addConstraints:@[ leftConstraintView, bottom, rightConstraintView ]];
  [subView addConstraint:self.heightConstraintView];
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
#pragma mark InforMenuSearchViewControlerDelegate
- (void)movingContainerScrollWithView:(UIView *)view andRect:(CGRect)rect {
    
    view.frame = rect;
    if (self.infoMenuSearch.isUpMoving)
    {
        self.heightConstraintView.constant -= self.infoMenuSearch.distanceMoving;
    }
    else
    {
        self.heightConstraintView.constant += self.infoMenuSearch.distanceMoving;
    }
    [self.infoMenuSearch.view setNeedsLayout];
}
@end
