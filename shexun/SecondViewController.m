//
//  SecondViewController.m
//  shexun
//
//  Created by mac on 15-10-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SecondViewController.h"
#import "DropdownMenu.h"

@interface SecondViewController ()<dropdownDelegate>
{
    
    ConditionDoubleTableView *tableView;
    NSArray *_titleArray;
    NSArray *_leftArray;
    NSArray *_rightArray;
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
    _mapView.showsUserLocation = YES;
    [self.view  addSubview:_mapView];
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    _firstload = false;
    [_locService startUserLocationService];
    [self testData];
    DropdownMenu *dropdown = [[DropdownMenu alloc] initDropdownWithButtonTitles:_titleArray andLeftListArray:_leftArray andRightListArray:_rightArray];
    dropdown.delegate = self;   //此句的代理方法可返回选中下标值
    [self.view addSubview:dropdown.view];
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

//测试数据
- (void)testData {
    [self testTitleArray];
    [self testLeftArray];
    [self testRightArray];
}

//每个下拉的标题
- (void) testTitleArray {
    _titleArray = @[@"附近", @"菜品"];
}

//左边列表可为空，则为单下拉菜单，可以根据需要传参
- (void)testLeftArray {
    NSArray *One_leftArray = @[@"附近", @"熱門商區", @"香洲區", @"斗門區", @"金灣區"];
    NSArray *Two_leftArray = [[NSArray alloc] init];
    //    NSArray *R_leftArray = @[@"Test1", @"Test2"];
    
    
    _leftArray = [[NSArray alloc] initWithObjects:One_leftArray, Two_leftArray, nil];
}

//右边列表不可为空
- (void)testRightArray {
    NSArray *F_rightArray = @[
                              @[
                                  @{@"title":@"500米"},
                                  @{@"title":@"1000米"},
                                  @{@"title":@"2000米"},
                                  @{@"title":@"5000米"}
                                  ] ,
                              @[
                                  @{@"title":@"全部商區"},
                                  @{@"title":@"拱北"},
                                  @{@"title":@"香洲"},
                                  @{@"title":@"吉大"},
                                  @{@"title":@"華髮商都"},
                                  @{@"title":@"富華里"},
                                  @{@"title":@"揚名廣場"},
                                  @{@"title":@"摩爾廣場"},
                                  @{@"title":@"井岸鎮"},
                                  @{@"title":@"紅旗鎮"},
                                  @{@"title":@"三灶鎮"},
                                  ],
                              @[
                                  @{@"title":@"全部香洲區"},
                                  @{@"title":@"拱北"},
                                  @{@"title":@"香洲"},
                                  @{@"title":@"吉大"},
                                  @{@"title":@"華髮商都"},
                                  @{@"title":@"富華里"},
                                  @{@"title":@"揚名廣場"},
                                  @{@"title":@"摩爾廣場"},
                                  ],
                              @[
                                  @{@"title":@"全部斗門區"},
                                  @{@"title":@"井岸鎮"},
                                  ],
                              @[
                                  @{@"title":@"全部金灣區"},
                                  @{@"title":@"紅旗鎮"},
                                  @{@"title":@"三灶鎮"},
                                  ]
                              ];
    
    NSArray *S_rightArray = @[
                              @[
                                  @{@"title":@"one"},
                                  @{@"title":@"two"},
                                  @{@"title":@"three"}
                                  ] ,
                              @[
                                  @{@"title":@"four"}
                                  ]
                              ];
    
    _rightArray = [[NSArray alloc] initWithObjects:F_rightArray, S_rightArray, nil];
}



//实现代理，返回选中的下标，若左边没有列表，则返回0
- (void)dropdownSelectedIndexArray:(NSArray *)indexarray {
    NSLog(@"%s : You choice %@ ,%@ and %@", __FUNCTION__,[indexarray objectAtIndex:0], [indexarray objectAtIndex:1], [indexarray objectAtIndex:2]);
}

@end
