//
//  MoreSettingViewController.h
//  shexun
//
//  Created by mac on 15-10-22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreSettingViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) IBOutlet UITableView * tableview;
@property (retain,nonatomic) NSArray * settingdata;

@end
