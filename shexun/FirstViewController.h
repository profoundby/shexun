//
//  FirstViewController.h
//  shexun
//
//  Created by mac on 15-10-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenuViewController.h"
#import <ImagePlayerView.h>

@interface FirstViewController : UIViewController<ImagePlayerViewDelegate>

@property (weak, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;
@property (nonatomic, strong) NSArray *imageURLs;

- (void)popleftmenu;
@end


