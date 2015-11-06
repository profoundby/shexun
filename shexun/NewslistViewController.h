//
//  NewslistViewController.h
//  shexun
//
//  Created by mac on 15-11-6.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImagePlayerView.h>

@interface NewslistViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ImagePlayerViewDelegate>

@property (nonatomic,retain) IBOutlet ImagePlayerView *imagePlayerView;
@property (nonatomic,retain) IBOutlet UISegmentedControl *newstab;
@property (nonatomic,retain) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *imageURLs;
@property (nonatomic, strong) NSMutableArray *newslist;
@property (nonatomic, strong) NSString * newscat;

-(void)updateNews;
-(void)catchange:(UISegmentedControl *)segmentcontrol;
@end
