//
//  CitylistViewController.h
//  shexun
//
//  Created by mac on 15-10-30.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitylistViewController : UIViewController<UITableViewDataSource,UITabBarDelegate>

@property (nonatomic,retain) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *cityList;
@property (nonatomic,strong) NSMutableArray *sectionList;

@end
