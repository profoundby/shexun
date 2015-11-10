//
//  SecondViewController.m
//  shexun
//
//  Created by mac on 15-10-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SecondViewController.h"
#import "DOPDropDownMenu.h"
#import "ServerAPI.h"
#import "AFUtil.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
    _mapView.showsUserLocation = YES;
    [self.view  addSubview:_mapView];
    NSArray *locarray = [self.location componentsSeparatedByString:@"|"];
    
        if([locarray count] == 3)
        {
            CLLocationCoordinate2D coor1;
            coor1.latitude = [[locarray objectAtIndex:1] doubleValue];
            coor1.longitude = [[locarray objectAtIndex:0] doubleValue];
            NSDictionary *tip =  BMKConvertBaiduCoorFrom(coor1,BMK_COORDTYPE_GPS);
            coor1=  BMKCoorDictionaryDecode(tip);
            BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coor1, BMKCoordinateSpanMake(0.05,0.05));
            BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
            [_mapView setRegion:adjustedRegion animated:YES];
           
            
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = [[locarray objectAtIndex:1] doubleValue];
            coor.longitude = [[locarray objectAtIndex:0] doubleValue];
            annotation.coordinate = coor;
            annotation.title = [NSString stringWithFormat:@"%@",[self.company objectForKey:@"companyname"]];
            [_mapView addAnnotation:annotation];
        }
    

 
    
    
    
    
    
  /*  _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    _firstload = false;
    [_locService startUserLocationService];*/
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    if(!_firstload)
    {
    _mapView.centerCoordinate = userLocation.location.coordinate;
    _firstload = true;
    }
}


- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"error %@",error);
}
@end
