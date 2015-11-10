//
//  NewslistViewController.m
//  shexun
//
//  Created by mac on 15-11-6.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NewslistViewController.h"
#import  <MBProgressHUD.h>
#import "AFUtil.h"
#import "ServerAPI.h"
#import <UIImageView+WebCache.h>
#import "UINewsTableViewCell.h"
#import "NewsDetailViewController.h"

@interface NewslistViewController ()

@end

@implementation NewslistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self.newstab addTarget:self action:@selector(catchange:) forControlEvents:UIControlEventValueChanged];
    self.newscat = SX_NEWSONLINE;
    [self updateNews];

    

}

-(void)updateNews
{
    void (^successblock)(id json);
    successblock = ^(id json)
    {
        NSMutableArray * rotationUrls = [[NSMutableArray alloc] init];
        for (int i=0; i<[[[json objectForKey:@"result"] objectForKey:@"mrotation"] count]; i++) {
            [rotationUrls addObject:[NSURL URLWithString:[[[[json objectForKey:@"result"] objectForKey:@"mrotation"] objectAtIndex:i] objectForKey:@"image"]]];
        }
        self.newslist = [[json objectForKey:@"result"] objectForKey:@"newslist"];
        self.imageURLs = rotationUrls;
        [self.imagePlayerView reloadData];
        [self.tableview reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AFUtil JSONDataWithUrl:[NSString stringWithFormat:@"%@%@%@",SERVER_PREFIX,SX_NEWSLIST,self.newscat] success:successblock fail:nil];
}

-(void)catchange:(UISegmentedControl *)segmentcontrol
{
     NSInteger index = segmentcontrol.selectedSegmentIndex;
    switch (index) {
        case 0:
            self.newscat = SX_NEWSONLINE;
            break;
        case 1:
            self.newscat = SX_NEWSPROMOTION;
            break;
        case 2:
            self.newscat = SX_NEWSPORDUCT;
            break;
    }
    [self updateNews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newslist.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    UINewsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"newscell"];
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[[self.newslist objectAtIndex:[indexPath row]]objectForKey:@"thumb" ]] placeholderImage:[UIImage imageNamed:@"ic_launcher"]];
    [cell.imageview setFrame:CGRectMake(10, 10, 90, 60)];
    cell.title.text=[[self.newslist objectAtIndex:[indexPath row]]objectForKey:@"title" ];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    NewsDetailViewController   *newsvc = (NewsDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"newsdetail"];
    newsvc.titletext =[[self.newslist objectAtIndex:[indexPath row]]objectForKey:@"title" ];
    newsvc.newsid = [[self.newslist objectAtIndex:[indexPath row]]objectForKey:@"id" ];
    [self showViewController:newsvc sender:self];*/
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    id theSegue = segue.destinationViewController;
    [theSegue setValue:[[self.newslist objectAtIndex:[self.tableview.indexPathForSelectedRow row]]objectForKey:@"title" ] forKey:@"titletext"];
    [theSegue setValue:[[self.newslist objectAtIndex:[self.tableview.indexPathForSelectedRow row]]objectForKey:@"id" ] forKey:@"newsid"];
    
}


@end
