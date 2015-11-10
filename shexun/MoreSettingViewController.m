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
    self.settingdata = [NSArray arrayWithObjects:@"扫描二维码",@"我的好友",@"生活服务",@"清除缓存",@"自动更新", nil];
    
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.58.com"]];
    }
    if([indexPath row] == 3)
    {
        [[[UIAlertView alloc] initWithTitle:@"清除缓存成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }
    else if([indexPath row] == 4)
    {
        [[[UIAlertView alloc] initWithTitle:@"此版本为最新版本" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }
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
    UIImageView *headview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"company_bg"]];
    headview.contentMode = UIViewContentModeScaleAspectFit;
    return  headview;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(tableView.frame.size.width/2 -100, 10, 200, 40)];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"注销登录" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    [button addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return  view;
}

-(void)logout:(id)sender
{
    [self.navigationController.tabBarController.parentViewController dismissViewControllerAnimated:NO completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

@end


