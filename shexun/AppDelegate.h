//
//  AppDelegate.h
//  shexun
//
//  Created by mac on 15-10-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BaiduMapAPI/BMapKit.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
}



@property (strong, nonatomic) UIWindow *window;


@end


