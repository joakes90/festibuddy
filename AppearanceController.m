//
//  AppearanceController.m
//  Festi Buddy
//
//  Created by Justin Oakes on 5/28/15.
//  Copyright (c) 2015 Oklasoft. All rights reserved.
//

#import "AppearanceController.h"

@import UIKit;

@implementation AppearanceController


+ (void) setupAppearance {
    UIColor *festiGreen = [UIColor colorWithRed:58.0/255.0 green:251.0/255.0 blue:72.0/255.0 alpha:1];
    UIColor *festiYellow = [UIColor colorWithRed:241.0/255.0 green:229.0/255.0 blue:16.0/255.0 alpha:1];
    UIColor *festiPink = [UIColor colorWithRed:1.0 green:129.0/255.0 blue:254.0/255.0 alpha:1];
    
    [[UINavigationBar appearance] setTintColor:festiPink];
    [[UINavigationBar appearance] setBarTintColor:festiGreen];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:festiPink forKey:NSForegroundColorAttributeName]];
    [[UIDatePicker appearance] setBackgroundColor:festiYellow];
    
    
}

@end
