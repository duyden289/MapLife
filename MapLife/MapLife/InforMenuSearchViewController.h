//
//  InforMenuSearchViewController.h
//  MapLife
//
//  Created by DenNH on 12/18/16.
//  Copyright © 2016 DenNH. All rights reserved.
//

#import "MenuSearchDraggingButton.h"
#import <UIKit/UIKit.h>

@interface InforMenuSearchViewController
    : UIViewController <MenuSearchDraggingButtonDelegate>

@property(weak, nonatomic) IBOutlet MenuSearchDraggingButton *draggingButton;

@end
