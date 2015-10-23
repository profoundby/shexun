//
//  RESideMenuViewController.m
//  shexun
//
//  Created by mac on 15-10-13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "RESideMenuViewController.h"

@implementation RESideMenuViewController

- (void)awakeFromNib
{
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.contentViewShadowColor = [UIColor blackColor];
    self.contentViewShadowOffset = CGSizeMake(0, 0);
    self.contentViewShadowOpacity = 0.6;
    self.contentViewShadowRadius = 12;
    self.contentViewShadowEnabled = YES;
    
    UITabBarController *tabvc =   [self.storyboard instantiateViewControllerWithIdentifier:@"maintabbar"];
    UIImage *tabitemimage0 = [UIImage imageNamed:@"home"];
    tabitemimage0 = [tabitemimage0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[tabvc.tabBar.items objectAtIndex:0] setFinishedSelectedImage:nil withFinishedUnselectedImage:tabitemimage0];
    [[tabvc.tabBar.items objectAtIndex:0] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    UIImage *tabitemimage1 = [UIImage imageNamed:@"near"];
    tabitemimage1 = [tabitemimage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[tabvc.tabBar.items objectAtIndex:1] setFinishedSelectedImage:nil withFinishedUnselectedImage:tabitemimage1];
    [[tabvc.tabBar.items objectAtIndex:1] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    UIImage *tabitemimage2 = [UIImage imageNamed:@"community"];
    tabitemimage2 = [tabitemimage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[tabvc.tabBar.items objectAtIndex:2] setFinishedSelectedImage:nil withFinishedUnselectedImage:tabitemimage2];
    [[tabvc.tabBar.items objectAtIndex:2] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    UIImage *tabitemimage3 = [UIImage imageNamed:@"event"];
    tabitemimage3 = [tabitemimage3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[tabvc.tabBar.items objectAtIndex:3] setFinishedSelectedImage:nil withFinishedUnselectedImage:tabitemimage3];
    [[tabvc.tabBar.items objectAtIndex:3] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    UIImage *tabitemimage4 = [UIImage imageNamed:@"more"];
    tabitemimage4 = [tabitemimage4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[tabvc.tabBar.items objectAtIndex:4] setFinishedSelectedImage:nil withFinishedUnselectedImage:tabitemimage4];
    self.contentViewController = tabvc;
    [[tabvc.tabBar.items objectAtIndex:4] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftMenuViewController"];
    self.backgroundImage = [UIImage imageNamed:@"Stars"];
    self.delegate = self;
}

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}


@end
