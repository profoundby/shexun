//
//  NearViewController.m
//  shexun
//
//  Created by mac on 15-10-26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NearViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AFUtil.h"
#import "ServerAPI.h"
#import  <MBProgressHUD.h>
#import "UICompanyTableCell.h"
#import "CompanyViewController.h"

@implementation NearViewController

-(void) viewDidLoad {
     [super viewDidLoad];
    self.categorys = @[@"企业"];
    self.subcategorys = @[@"分类"];
    self.distances = @[@"距离"];
    self.orders = @[@"筛选"];
    self.results = self.originalArray;
    self.categorysdic = [[NSMutableDictionary alloc] init];
    
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:40];
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    self.menu = menu;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AFUtil JSONDataWithUrl:[NSString stringWithFormat:@"%@%@",SERVER_PREFIX,SX_COMCAT] success:^(id json) {
        
        NSMutableArray * cats = [[NSMutableArray alloc] init];
        for (int i=0;i < [[[json objectForKey:@"result"] objectForKey:@"catids"] count] ; i++) {
            [cats addObject: [[[[json objectForKey:@"result"] objectForKey:@"catids"] objectAtIndex:i] objectForKey:@"catname"]];
            [self.categorysdic setObject:[[[json objectForKey:@"result"] objectForKey:@"catids"] objectAtIndex:i]  forKey:[[[[json objectForKey:@"result"] objectForKey:@"catids"] objectAtIndex:i] objectForKey:@"catname"]];
        }
        self.categorys = cats;
        NSMutableArray *ords = [[NSMutableArray alloc] init];
        [ords addObject:@"全部"];
        self.ordersdic = [[json objectForKey:@"result"] objectForKey:@"orders"];
        for (int i=0; i<[self.ordersdic count];i++) {
            [ords addObject:[[self.ordersdic allValues] objectAtIndex:i]];
        }
        self.orders = ords;
        
    } fail:^{
        
    }];
    
    
    void (^successblock)(id json);
    successblock = ^(id json)
    {
        self.nearcomdata = [json objectForKey:@"result"];
        [self.tableview reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    };
    [AFUtil JSONDataWithUrl:[NSString stringWithFormat:@"%@%@",SERVER_PREFIX,SX_NEARCOM] success:successblock fail:nil];
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 4;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    switch (column) {
        case 0: return self.categorys.count;
            break;
        case 1: return self.subcategorys.count;
            break;
        case 2: return self.distances.count;
            break;
        case 3: return self.orders.count;
            break;
        default:
            return 1;
            break;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    switch (indexPath.column) {
        case 0: return self.categorys[indexPath.row];
            break;
        case 1: return self.subcategorys[indexPath.row];
            break;
        case 2: return self.distances[indexPath.row];
            break;
        case 3: return self.orders[indexPath.row];
            break;
        default:
            return nil;
            break;
    }
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
    NSLog(@"column:%li row:%li", (long)indexPath.column, (long)indexPath.row);
    NSLog(@"%@",[menu titleForRowAtIndexPath:indexPath]);
    if([indexPath column] == 0)
    {
      NSMutableArray *subids = [[self.categorysdic objectForKey:[menu titleForRowAtIndexPath:indexPath]] objectForKey:@"subid"];
        NSMutableArray * cats = [[NSMutableArray alloc] init];
        for (int i=0; i<[subids count]; i++) {
            [cats  addObject:[[subids objectAtIndex:i] objectForKey:@"catname"]];
        }
        self.subcategorys = cats;
    }
    

    
    self.results = nil;
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
    static NSString *CellIdentifier = @"companycell";
    //自定义cell类
    UICompanyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UICompanyTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.comName.text=[[self.nearcomdata objectAtIndex:[indexPath row]] objectForKey:@"companyname"];
    NSString *distance = [NSString stringWithFormat:[NSString stringWithFormat:@"%%.2f" ],[[[self.nearcomdata objectAtIndex:[indexPath row]] objectForKey:@"distance"] floatValue]];
    cell.comDistance.text = [NSString stringWithFormat:@"相距%@公里",distance];
    [cell.comImage  sd_setImageWithURL:[NSURL URLWithString:[[self.nearcomdata objectAtIndex:[indexPath row]] objectForKey:@"logo"]] placeholderImage:nil];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     //CompanyViewController *companyvc = [[CompanyViewController alloc] init];
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //CompanyServiceViewController *servicecollection = [storyboard instantiateViewControllerWithIdentifier:@"companyservice"];
    //[self.navigationController pushViewController:companyvc animated:YES];
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
