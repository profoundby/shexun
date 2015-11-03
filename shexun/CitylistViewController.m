//
//  CitylistViewController.m
//  shexun
//
//  Created by mac on 15-10-30.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CitylistViewController.h"
#import "Pinyin.h"

@implementation CitylistViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    self.cityList = [NSArray arrayWithObjects:@"常州",@"上海",@"北京", nil];
    for (NSString *city in self.cityList) {
        char  c = pinyinFirstLetter([city characterAtIndex:0]);
        [self.sectionList addObject:[[NSString stringWithFormat:@"%c",c] uppercaseString]];
    }
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cityList.count;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cityList.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    static NSString *CellIdentifier = @"companycell";
    //自定义cell类
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.cityList objectAtIndex:[indexPath row]];
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    char  c = pinyinFirstLetter([[self.cityList objectAtIndex:section] characterAtIndex:0]);
    //[self.sectionList addObject:[[NSString stringWithFormat:@"%c",c] uppercaseString]];
    return [[NSString stringWithFormat:@"%c",c] uppercaseString];
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return nil;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return self.sectionList;
    
}


@end
