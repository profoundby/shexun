//
//  FirstViewController.m
//  shexun
//
//  Created by mac on 15-10-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "FirstViewController.h"
#import  <SDWebImage/UIImageView+WebCache.h>
#import <MBProgressHUD.h>
#import "AFUtil.h"
#import "ServerAPI.h"
#import "UIIndexCollectionHeadView.h"
#import "UIIndexCollectionCell.h"
#import "NewsDetailViewController.h"

@interface FirstViewController ()　

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self.navigationController.navigationItem.leftBarButtonItem performSelector:(@selector(popleftmenu)) withObject:nil afterDelay:0];
    self.indexTitleArray = [NSArray arrayWithObjects:@"新闻·资讯",@"企业·采风",@"热门·企业", nil];
    self.imageURLs = @[[NSURL URLWithString:@"http://sudasuta.com/wp-content/uploads/2013/10/10143181686_375e063f2c_z.jpg"]];
    
    self.imagePlayerView.imagePlayerViewDelegate = self;
    
    // set auto scroll interval to x seconds
    self.imagePlayerView.scrollInterval = 5.0f;
    
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    self.imagePlayerView.hidePageControl = NO;
    
    // adjust edgeInset
    //    self.imagePlayerView.edgeInsets = UIEdgeInsetsMake(10, 20, 30, 40);
    
    [self.imagePlayerView reloadData];
    void (^successblock)(id json);
    successblock = ^(id json)
    {
        //NSLog(@"%@",json);
        self.indexDic= json;
        NSMutableArray * rotationUrls = [[NSMutableArray alloc] init];
        for (int i=0; i<[[[self.indexDic objectForKey:@"result"] objectForKey:@"mrotation"] count]; i++) {
            [rotationUrls addObject:[NSURL URLWithString:[[[[self.indexDic objectForKey:@"result"] objectForKey:@"mrotation"] objectAtIndex:i] objectForKey:@"image"]]];
        }
        self.imageURLs = rotationUrls;
        [self.imagePlayerView reloadData];
        [self.collectionView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AFUtil JSONDataWithUrl:[NSString stringWithFormat:@"%@%@",SERVER_PREFIX,SX_INDEX] success:successblock fail:nil];
    
}

- (void)popleftmenu{
    [(RESideMenuViewController *)self.navigationController.tabBarController.parentViewController presentLeftMenuViewController];
    
    
}

#pragma mark - ImagePlayerViewDelegate
- (NSInteger)numberOfItems
{
    return self.imageURLs.count;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    // recommend to use SDWebImage lib to load web image
    //    [imageView setImageWithURL:[self.imageURLs objectAtIndex:index] placeholderImage:nil];
    
    [imageView sd_setImageWithURL:[self.imageURLs objectAtIndex:index] placeholderImage:[UIImage imageNamed:@"login"]];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return  4;
    }
    else
        return  6;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"GradientCell";
    UIIndexCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if ([indexPath section] == 0) {
        [cell.logo sd_setImageWithURL:[[[[self.indexDic objectForKey:@"result"] objectForKey:@"newslist"] objectAtIndex:[indexPath row]] objectForKey:@"thumb"] placeholderImage:[UIImage imageNamed:@"ic_launcher"]];
        [cell.title setText:[[[[self.indexDic objectForKey:@"result"] objectForKey:@"newslist"] objectAtIndex:[indexPath row]] objectForKey:@"title"]];
        [cell.title setHidden:NO];
    }
    else
    {
    [cell.logo sd_setImageWithURL:[[[[self.indexDic objectForKey:@"result"] objectForKey:@"companylist"] objectAtIndex:[indexPath row]] objectForKey:@"logo"] placeholderImage:[UIImage imageNamed:@"ic_launcher"]];
    [cell.title setHidden:YES];
    }
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section] < 2 || ([indexPath section] == 2 && [indexPath row] < 2))
    {
      return CGSizeMake((collectionView.frame.size.width -20)/2, 100);
    }
     else
    return CGSizeMake((collectionView.frame.size.width -40)/4, 100);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        NewsDetailViewController   *newsvc = (NewsDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"newsdetail"];
        newsvc.titletext =[[[[self.indexDic objectForKey:@"result"] objectForKey:@"newslist"] objectAtIndex:[indexPath row]] objectForKey:@"title"];
        newsvc.newsid = [[[[self.indexDic objectForKey:@"result"] objectForKey:@"newslist"] objectAtIndex:[indexPath row]] objectForKey:@"id"];
        [self showViewController:newsvc sender:self];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UIIndexCollectionHeadView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionHead" forIndexPath
                                                                                                   :indexPath];
    reusableview.headLabel.text = [self.indexTitleArray objectAtIndex:[indexPath section]];

    return reusableview;
    
}

@end
