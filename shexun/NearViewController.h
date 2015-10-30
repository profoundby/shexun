//
//  NearViewController.h
//  shexun
//
//  Created by mac on 15-10-26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOPDropDownMenu.h"

@interface NearViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DOPDropDownMenuDelegate,DOPDropDownMenuDataSource>

@property (nonatomic, copy) NSArray *citys;
@property (nonatomic, copy) NSArray *ages;
@property (nonatomic, copy) NSArray *genders;
@property (nonatomic, copy) NSArray *originalArray;
@property (nonatomic, copy) NSArray *results;

@property (nonatomic, strong) IBOutlet DOPDropDownMenu *menu;

@property (strong,nonatomic) IBOutlet UITableView * tableview;
@property (retain,nonatomic) NSArray * nearcomdata;

@end
