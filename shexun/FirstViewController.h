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

@interface FirstViewController : UIViewController<ImagePlayerViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;
@property (nonatomic, strong) NSArray *imageURLs;
@property (nonatomic, copy) NSDictionary *indexDic;
@property (nonatomic, strong) NSArray *indexTitleArray;
@property (nonatomic,retain) IBOutlet UICollectionView *collectionView;


- (void)popleftmenu;
@end


