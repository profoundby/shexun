//
//  NewsDetailViewController.h
//  shexun
//
//  Created by mac on 15-11-3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic,retain) IBOutlet UIWebView * contentWebview;
@property (nonatomic,retain) IBOutlet UILabel *newstitle;

@property (nonatomic,weak) NSString * titletext;
@property (nonatomic,weak) NSString * newsid;

@end
