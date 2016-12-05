//
//  ViewInfo.m
//  MapLife
//
//  Created by DenNH on 11/20/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import "ViewInfo.h"

@implementation ViewInfo

- (void)awakeFromNib {
  [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:0.33 green:0.61 blue:0.85 alpha:0.4];
}
- (void)loadInfoAddress:(NSString *)address {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        [self animatedLabelShowText:address characterDelay:0.02];
    });
  
}
/**
 *  <#Description#>
 *
 *  @param newText <#newText description#>
 *  @param delay   <#delay description#>
 */
- (void)animatedLabelShowText:(NSString *)newText
               characterDelay:(NSTimeInterval)delay {
    self.infoAdress.text = @"";
    for (NSInteger i = 0; i < newText.length; i++) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.infoAdress
             setText:[NSString stringWithFormat:@"%@%C",
                      self.infoAdress.text,
                      [newText characterAtIndex:i]]];
            
        });
        [NSThread sleepForTimeInterval:delay];
    }
}
@end
