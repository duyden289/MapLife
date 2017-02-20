//
//  MSharedPreferences.m
//  MapLife
//
//  Created by DenNH on 1/18/17.
//  Copyright © 2017 DenNH. All rights reserved.
//

#import "MSharedPreferences.h"

NSString *const MUserDefaultLocationParentKey = @"pre_location_parent";

@interface MSharedPreferences()

@property (nonatomic, strong) NSUserDefaults *userDefault;

@end

@implementation MSharedPreferences

+(MSharedPreferences *)sharedInstance
{
    static dispatch_once_t onceToken;
    static MSharedPreferences *sharedSingleton;
    // Init object
    dispatch_once(&onceToken, ^{
        // Init VTSharePreferences instance
        sharedSingleton = [[MSharedPreferences alloc] init];
    });
    
    return sharedSingleton;
}
- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        _userDefault = [NSUserDefaults standardUserDefaults];
        [self loadInitValueOfProperties];
    }
    return self;
}
- (void)loadInitValueOfProperties
{
    [self loadLocationParent];
}
- (void)loadLocationParent
{
    NSData *data = [self.userDefault objectForKey:MUserDefaultLocationParentKey];
    _locationParent = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
}
- (void)setLocationParent:(CLLocation *)locationParent
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:locationParent];
    [self.userDefault setObject:data forKey:MUserDefaultLocationParentKey];
    _locationParent = locationParent;
}
@end
