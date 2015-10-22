//
//  MoreSettingViewController.m
//  shexun
//
//  Created by mac on 15-10-22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MoreSettingViewController.h"

@implementation MoreSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
    self.settingdata = [NSArray arrayWithObjects:@"扫描二维码",@"我的好友",@"生活服务",@"清楚缓存",@"自动更新", nil];
    
    //创建一个分组样式的UITableView
    self.tableview=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    self.tableview.dataSource=self;
    self.tableview.delegate = self;
}




#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.settingdata.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=[self.settingdata objectAtIndex:[indexPath row]];
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return @"个人中心";
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *headview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_logo"]];
    return  headview;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIImageView *headview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login"]];
    return  headview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

@end


