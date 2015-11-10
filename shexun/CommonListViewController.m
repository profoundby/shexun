//
//  CommonListViewController.m
//  shexun
//
//  Created by mac on 15-11-10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CommonListViewController.h"
#import <MBProgressHUD.h>
#import "AFUtil.h"
@interface CommonListViewController ()

@end

@implementation CommonListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.mode = MBProgressHUDModeText;
    hud.labelText = @"正在获取列表数据";
    [AFUtil JSONDataWithUrl:self.interface success:^(id json) {
        [hud hide:YES];
        self.dataarray =[[json objectForKey:@"result"] objectForKey:self.datakey];
        [self.tableview reloadData];
    } fail:^{
        [hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"数据获取失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];

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

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataarray.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=[[self.dataarray objectAtIndex:[indexPath row]]objectForKey:self.titlekey ];
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



@end
