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

@property (nonatomic, copy) NSArray *categorys;
@property (nonatomic, strong) NSMutableDictionary *categorysdic;
@property (nonatomic, copy) NSArray *subcategorys;
@property (nonatomic, strong) NSMutableDictionary *subcategorysdic;
@property (nonatomic, copy) NSArray *distances;
@property (nonatomic, strong) NSMutableDictionary *distancesdic;
@property (nonatomic, copy) NSArray *orders;
@property (nonatomic, strong) NSMutableDictionary *ordersdic;
@property (nonatomic, copy) NSArray *originalArray;
@property (nonatomic, copy) NSArray *results;

@property (nonatomic, strong) IBOutlet DOPDropDownMenu *menu;

@property (strong,nonatomic) IBOutlet UITableView * tableview;
@property (retain,nonatomic) NSArray * nearcomdata;

@end
