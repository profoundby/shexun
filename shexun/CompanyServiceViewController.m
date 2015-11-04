//
//  CompanyServiceViewControllerCollectionViewController.m
//  
//
//  Created by baoyuan on 15/11/3.
//
//

#import "CompanyServiceViewController.h"
#import "CompanyServiceCell.h"
#import <UIImageView+WebCache.h>

@interface CompanyServiceViewController ()

@end

@implementation CompanyServiceViewController

static NSString * const reuseIdentifier = @"companyservicecell";

/*- (instancetype)init
 {
         //创建流水布局对象
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize =  [UIScreen mainScreen].bounds.size;
    
         //设置水平滚动
         layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
         //    // 设置cell之间间距
         layout.minimumInteritemSpacing = 0;
         //    // 设置行距
         layout.minimumLineSpacing = 0;
    
         return [super initWithCollectionViewLayout:layout];
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.serviceimages = [NSArray arrayWithObjects:@"weibo_com_icon_about",@"weibo_com_icon_news",@"weibo_com_icon_product",@"weibo_com_icon_3d",@"weibo_com_icon_location",
                          @"weibo_com_icon_video",@"weibo_com_icon_joinus",@"weibo_com_icon_weiapp",nil];
    self.servicetexts = [NSArray arrayWithObjects:@"企业概况\n眼疾手快，迅速了解企业概况",@"企业资讯\n随时随地，知晓企业全方位资讯",@"产品中心",@"3D展厅",@"地理位置",
                          @"企业视频",@"人才招聘",@"微APP",nil];
    
    // Register cell classes
    //[self.collectionView registerClass:[CompanyServiceCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView reloadData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)segmentTitle
{
    return @"企业服务";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
