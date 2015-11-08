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

@interface CompanyViewController ()

@end

@implementation CompanyViewController

static NSString * const reuseIdentifier = @"companyservicecell";
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
    self.servicetexts = [NSArray arrayWithObjects:@"企业概况\n眼疾手快，迅速了解企业概况",@"企业资讯\n随时随地，知晓企业全方位资讯",@"产品中心",@"3D展厅",@"地理位置",
                         @"企业视频",@"人才招聘",@"微APP",nil];
    
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
    
    [self.scrollview bringSubviewToFront:self.activityview];

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
    return 5;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    //UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"newscell"];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
  
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld",(long)[indexPath row]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    NewsDetailViewController   *newsvc = (NewsDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"newsdetail"];
    newsvc.titletext =[[self.newslist objectAtIndex:[indexPath row]]objectForKey:@"title" ];
    newsvc.newsid = [[self.newslist objectAtIndex:[indexPath row]]objectForKey:@"id" ];
    [self showViewController:newsvc sender:self];*/
}



@end
