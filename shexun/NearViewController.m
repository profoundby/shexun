//
//  NearViewController.m
//  shexun
//
//  Created by mac on 15-10-26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NearViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation NearViewController

-(void) viewDidLoad {
     [super viewDidLoad];
    self.citys = @[NSLocalizedString(@"city1", @"city1"),
                   NSLocalizedString(@"city2", @"city2"),
                   NSLocalizedString(@"city3", @"city3")];
    self.ages = @[NSLocalizedString(@"age", @"age"), @"20", @"30"];
    self.genders = @[NSLocalizedString(@"gender1", @"gender1"),
                     NSLocalizedString(@"gender2", @"gender2"),
                     NSLocalizedString(@"gender3", @"gender3")];
    self.originalArray = @[[NSString stringWithFormat:@"%@_%@_%@",self.citys[1],self.ages[1],self.genders[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[1],self.ages[1],self.genders[2]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[1],self.ages[2],self.genders[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[1],self.ages[2],self.genders[2]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[2],self.ages[1],self.genders[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[2],self.ages[1],self.genders[2]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[2],self.ages[2],self.genders[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[2],self.ages[2],self.genders[2]]];
    self.results = self.originalArray;
    
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:40];
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    self.menu = menu;
    NSString *datastr = @"[{'image':'http://os.blog.163.com/common/ava.s?b=1&host=fei263','name':'测试企业1'},{'image':'http://ww3.sinaimg.cn/square/6988e5fejw1exegs6da1qj209q09qmy9.jpg','name':'测试企业2'}]";
    self.nearcomdata = [NSJSONSerialization JSONObjectWithData:[datastr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    return 3;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    switch (indexPath.column) {
        case 0: return self.citys[indexPath.row];
            break;
        case 1: return self.genders[indexPath.row];
            break;
        case 2: return self.ages[indexPath.row];
            break;
        default:
            return nil;
            break;
    }
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
    NSLog(@"column:%li row:%li", (long)indexPath.column, (long)indexPath.row);
    NSLog(@"%@",[menu titleForRowAtIndexPath:indexPath]);
    NSString *title = [menu titleForRowAtIndexPath:indexPath];
    
    static NSString *prediStr1 = @"SELF LIKE '*'",
    *prediStr2 = @"SELF LIKE '*'",
    *prediStr3 = @"SELF LIKE '*'";
    switch (indexPath.column) {
        case 0:{
            if (indexPath.row == 0) {
                prediStr1 = @"SELF LIKE '*'";
            } else {
                prediStr1 = [NSString stringWithFormat:@"SELF CONTAINS '%@'", title];
            }
        }
            break;
        case 1:{
            if (indexPath.row == 0) {
                prediStr2 = @"SELF LIKE '*'";
            } else {
                prediStr2 = [NSString stringWithFormat:@"SELF CONTAINS '%@'", title];
            }
        }
            break;
        case 2:{
            if (indexPath.row == 0) {
                prediStr3 = @"SELF LIKE '*'";
            } else {
                prediStr3 = [NSString stringWithFormat:@"SELF CONTAINS '%@'", title];
            }
        }
            
        default:
            break;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ AND %@ AND %@",prediStr1,prediStr2,prediStr3]];
    
    self.results = [self.originalArray filteredArrayUsingPredicate:predicate];
}


#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nearcomdata.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=[[self.nearcomdata objectAtIndex:[indexPath row]] objectForKey:@"name"];
    [cell.imageView  sd_setImageWithURL:[NSURL URLWithString:[[self.nearcomdata objectAtIndex:[indexPath row]] objectForKey:@"image"]] placeholderImage:nil];
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return nil;
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return nil;
}

/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *headview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_logo"]];
    return  headview;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIImageView *headview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login"]];
    return  headview;
} */


@end