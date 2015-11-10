//
//  SecondViewController.h
//  shexun
//
//  Created by mac on 15-10-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>

@interface SecondViewController : UIViewController <BMKLocationServiceDelegate>

{
    BMKLocationService *_locService;
    BMKMapView* _mapView;
    BOOL  _firstload;
}

@property (nonatomic,copy) NSString * location;


@end

