//
//  ViewInfo.h
//  MapLife
//
//  Created by DenNH on 11/20/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewInfo : UIView
@property(weak, nonatomic) IBOutlet UILabel *infoAdress;
/**
 *  <#Description#>
 *
 *  @param address <#address description#>
 */
- (void)loadInfoAddress:(NSString *)address;
@end
