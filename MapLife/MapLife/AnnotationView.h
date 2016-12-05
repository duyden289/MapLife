//
//  AnnotationView.h
//  MapLife
//
//  Created by DenNH on 11/20/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface AnnotationView : MKAnnotationView

/**
 *  <#Description#>
 */
@property(nonatomic, strong) UIView *pinView;
/**
 *  <#Description#>
 */
@property(nonatomic, strong) UIView *calloutView;

/**
 *  Instancetype with annotation
 *
 *  @param annotation      <#annotation description#>
 *  @param reuseIdentifier <#reuseIdentifier description#>
 *  @param pinView         <#pinView description#>
 *  @param calloutView     <#calloutView description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation
                   reuseIdentifier:(NSString *)reuseIdentifier
                           pinView:(UIView *)pinView
                       calloutView:(UIView *)calloutView;
- (void)showCalloutView;

@end
