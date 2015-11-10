//
//  CompanyViewController.m
//  
//
//  Created by baoyuan on 15/11/3.
//
//

#import "CompanyViewController.h"
#import "CompanyServiceCell.h"
#import <UIImageView+WebCache.h>
#import "AFUtil.h"
#import "ServerAPI.h"
#import <MBProgressHUD.h>
#import "CompanyActivityTableViewCell.h"
#import "NewsDetailViewController.h"
#import "CommonListViewController.h"
#import "SecondViewController.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController

static NSString * const reuseIdentifier = @"companyservicecell";
static NSString * const identifier = @"Cell";
@synthesize company;


- (void)viewDidLoad {
    [super viewDidLoad];
    /*CompanyActivityViewController *activitytable = [[CompanyActivityViewController alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
   // CompanyServiceViewController *servicecollection = [storyboard instantiateViewControllerWithIdentifier:@"companyservice"];
    CompanyServiceViewController *servicecollection  = [[CompanyServiceViewController alloc]init];
    CompanyCardViewController  *cardtable = [[CompanyCardViewController alloc]init];
    [self.scrollview addSubview:servicecollection.view];*/
    self.serviceimages = [NSArray arrayWithObjects:@"weibo_com_icon_about",@"weibo_com_icon_news",@"weibo_com_icon_product",@"weibo_com_icon_3d",@"weibo_com_icon_location",
                          @"weibo_com_icon_video",@"weibo_com_icon_joinus",@"weibo_com_icon_weiapp",nil];
    self.servicetexts = [NSArray arrayWithObjects:@"企业概况\n眼疾手快，迅速了解企业概况",@"企业资讯\n随时随地，知晓企业全方位资讯",@"产品中心\n万千产品，指尖一览而过",@"3D展厅\n720度视角，解读企业实景",@"地理位置\nGPS导航，迅速找到我们",
                         @"企业视频\n视频富媒体，真实生动展示",@"人才招聘\n求贤若渴，期待优秀的您加入",@"微APP\n掌握无线商机，拓展无限上午渠道",nil];
    
    // Register cell classes
    //[self.collectionView registerClass:[CompanyServiceCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView reloadData];
    self.segment.layer.cornerRadius = 0;
    [self.segment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.cardview = [CompanyCardView initview];
    [self.cardview setFrame:CGRectMake(0, 0, self.scrollview.frame.size.width, self.view.frame.size.height)];
    self.activityview = [CompanyActivityView initview];
    self.activityview.tableview.dataSource = self;
    self.activityview.tableview.delegate = self;
    [self.activityview setFrame:CGRectMake(0, 0, self.scrollview.frame.size.width, self.view.frame.size.height)];
    [self.companylogo sd_setImageWithURL:[NSURL URLWithString:[company objectForKey:@"logo"]] placeholderImage:[UIImage imageNamed:@"ic_launcher"]];
    [self.companyname setText:[company objectForKey:@"companyname"]];
    [self.scrollview addSubview:self.activityview];
    [self.scrollview addSubview:self.collectionView];
    [self.scrollview addSubview:self.cardview];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[self.company objectForKey:@"web_url"]];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    self.cardview.website.attributedText = content;
    [self.cardview.introduce setText:[AFUtil removeHTML:[self.company objectForKey:@"introduce"]]];
    [self.cardview.tel setText:[self.company objectForKey:@"telephone"]];
    [self.cardview.address setText:[self.company objectForKey:@"address"]];
    [self.activityview.tableview registerNib:[UINib nibWithNibName:@"CompanyActivityTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];

    [self.scrollview bringSubviewToFront:self.activityview];
    UITapGestureRecognizer *tapGestureWeb = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openWebpage:)];
    [self.cardview.website addGestureRecognizer:tapGestureWeb];
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openDialpage:)];
    [self.cardview.tel addGestureRecognizer:tapGestureTel];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AFUtil JSONDataWithUrl:[NSString stringWithFormat:@"%@%@&userid=%@",SERVER_PREFIX,SX_COMPANY,[self.company objectForKey:@"userid"]] success:^(id json) {
        if([[json objectForKey:@"status"] integerValue] == 200) {
            self.companyactivities = [[json objectForKey:@"result"] objectForKey:@"activities"];
            [self.companyfans setText:[NSString stringWithFormat:@"粉丝：%@  人气：%@",[[json objectForKey:@"result"] objectForKey:@"fans"],[[json objectForKey:@"result"] objectForKey:@"hits"]]];
            [self.activityview.tableview reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    } fail:^{
       [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    [AFUtil JSONDataWithUrl:[NSString stringWithFormat:@"%@%@&userid=%@",SERVER_PREFIX,SX_ADDHIT,[self.company objectForKey:@"userid"]] success:nil fail:nil];
    [AFUtil JSONDataWithUrl:[NSString stringWithFormat:@"%@%@&userid=%@&companyid=%@",SERVER_PREFIX,SX_ISFANS,[[[NSUserDefaults standardUserDefaults] objectForKey:@"userinfo"] objectForKey:@"userid"],[self.company objectForKey:@"userid"]] success:^(id json) {
         if([[json objectForKey:@"status"] integerValue] == 200)
         {
             [self.subscribebtn setTitle:@"取消" forState:UIControlStateNormal];
         }
     }
    fail:^{
                            
     }];
    [self.subscribebtn addTarget:self action:@selector(addfans:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)addfans:(UIButton *)sender
{
    if([sender.titleLabel.text isEqual:@"关注"])
    {
        [AFUtil JSONDataWithUrl:[NSString stringWithFormat:@"%@%@&userid=%@&companyid=%@",SERVER_PREFIX,SX_ADDFANS,[[[NSUserDefaults standardUserDefaults] objectForKey:@"userinfo"] objectForKey:@"userid"],[self.company objectForKey:@"userid"]] success:^(id json) {
            if([[json objectForKey:@"status"] integerValue] == 200)
            {
                [self.subscribebtn setTitle:@"取消" forState:UIControlStateNormal];
                [[[UIAlertView alloc] initWithTitle:@"关注成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            }
            else
            {
                [self.subscribebtn setTitle:@"取消" forState:UIControlStateNormal];
                [[[UIAlertView alloc] initWithTitle:[json  objectForKey:@"result"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            }
        }
             fail:^{
                [[[UIAlertView alloc] initWithTitle:@"获取数据失败，请稍后重试" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
                 
             }];
    }
    else
    {
        [AFUtil JSONDataWithUrl:[NSString stringWithFormat:@"%@%@&userid=%@&companyid=%@",SERVER_PREFIX,SX_DELFANS,[[[NSUserDefaults standardUserDefaults] objectForKey:@"userinfo"] objectForKey:@"userid"],[self.company objectForKey:@"userid"]] success:^(id json) {
            if([[json objectForKey:@"status"] integerValue] == 200)
            {
                [self.subscribebtn setTitle:@"关注" forState:UIControlStateNormal];
                [[[UIAlertView alloc] initWithTitle:@"取消关注成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            }
            else
            {
                [self.subscribebtn setTitle:@"关注" forState:UIControlStateNormal];
                [[[UIAlertView alloc] initWithTitle:[json  objectForKey:@"result"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            }
        }
                           fail:^{
                               [[[UIAlertView alloc] initWithTitle:@"获取数据失败，请稍后重试" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
                               
                           }];
    }
    
}

-(void)openWebpage:(UITapGestureRecognizer *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",self.cardview.website.text]]];
}

-(void)openDialpage:(UITapGestureRecognizer *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.cardview.tel.text]]];
}

-(void)segmentChanged:(UISegmentedControl*)segmentcontrol
{
    if (segmentcontrol.selectedSegmentIndex == 0) {
       
        [self.scrollview bringSubviewToFront:self.activityview];
    }
    
    else if (segmentcontrol.selectedSegmentIndex == 1) {
        [self.scrollview bringSubviewToFront:self.collectionView];
        
    }
    else
    {
       [self.scrollview bringSubviewToFront:self.cardview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.z
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.serviceimages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CompanyServiceCell *cell = (CompanyServiceCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.servicelogo setImage:[UIImage imageNamed:[self.serviceimages objectAtIndex:[indexPath row]]]];
    [cell.servicetext setText:[self.servicetexts objectAtIndex:[indexPath row]]];
    // Configure the cell
    
    
    return cell;

}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((collectionView.frame.size.width -20)/2, 80);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == 0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        NewsDetailViewController   *newsvc = (NewsDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"newsdetail"];
        newsvc.titletext =@"企业详情";
        newsvc.content = [self.company objectForKey:@"introduce" ];
        [self showViewController:newsvc sender:self];
    }
    else if([indexPath row] == 1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        CommonListViewController   *comvc = (CommonListViewController *)[storyboard instantiateViewControllerWithIdentifier:@"commonlist"];
        comvc.interface = [NSString stringWithFormat:@"%@%@&userid=%@",SERVER_PREFIX,SX_NEWSLIST,[self.company objectForKey:@"userid"]];
        comvc.titlekey = @"title";
        comvc.datakey = SX_NEWSLIST;
        [self showViewController:comvc sender:self];
    }
    
    else if([indexPath row] == 6)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        CommonListViewController   *comvc = (CommonListViewController *)[storyboard instantiateViewControllerWithIdentifier:@"commonlist"];
        comvc.interface = [NSString stringWithFormat:@"%@%@&userid=%@",SERVER_PREFIX,SX_JOBLIST,[self.company objectForKey:@"userid"]];
        comvc.titlekey = @"title";
        comvc.datakey = SX_JOBLIST;
        [self showViewController:comvc sender:self];
    }
    
    else if([indexPath row] == 4)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        SecondViewController   *mapvc = (SecondViewController *)[storyboard instantiateViewControllerWithIdentifier:@"mapview"];
        mapvc.location = [self.company objectForKey:@"map"];
        mapvc.company = self.company;
        [self showViewController:mapvc sender:self];
    }
    else if([indexPath row] == 7)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.shexun.net.cn/index.php?m=yp&c=com_index&userid=%@",[self.company objectForKey:@"userid"]]]];
    }
    
    
    
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
    if ([self.companyactivities isEqual:[NSNull null]]) {
        return 0;
    }
    return [self.companyactivities count];
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CompanyActivityTableViewCell *cell = (CompanyActivityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CompanyActivityTableViewCell" owner:self options:nil] lastObject];
    }
    CGSize boundSize = CGSizeMake(216, CGFLOAT_MAX);
    cell.companyname.text = [self.company objectForKey:@"companyname"];
    cell.activitytitle.text = [[[self.company objectForKey:@"activities"] objectAtIndex:[indexPath row]] objectForKey:@"title"];
    cell.activitycontent.text = [[[self.company objectForKey:@"activities"] objectAtIndex:[indexPath row]] objectForKey:@"content"];
    [cell.companylogo sd_setImageWithURL:[NSURL URLWithString:[self.company objectForKey:@"logo"]]];
    CGSize requiredSize = [cell.activitycontent.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:boundSize lineBreakMode:NSLineBreakByWordWrapping];
    CGRect rect = cell.frame;
    rect.size.height = requiredSize.height;
    cell.frame = rect;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    NewsDetailViewController   *newsvc = (NewsDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"newsdetail"];
    newsvc.titletext =[[self.newslist objectAtIndex:[indexPath row]]objectForKey:@"title" ];
    newsvc.newsid = [[self.newslist objectAtIndex:[indexPath row]]objectForKey:@"id" ];
    [self showViewController:newsvc sender:self];*/
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

@end
