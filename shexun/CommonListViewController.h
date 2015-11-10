//
//  CommonListViewController.h
//  shexun
//
//  Created by mac on 15-11-10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) IBOutlet UITableView *tableview;
@property (nonatomic,copy)   NSArray *dataarray;
@property (nonatomic,copy)   NSString *titlekey;
@property (nonatomic,copy)   NSString *interface;
@property (nonatomic,copy)   NSString *datakey;

@end
