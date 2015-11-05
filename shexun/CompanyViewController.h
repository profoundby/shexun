//
//  CompanyViewController.h
//  
//
//  Created by baoyuan on 15/11/3.
//
//
#import <UIKit/UIKit.h>

@interface CompanyViewController :UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain) IBOutlet UIImageView *companylogo;
@property (nonatomic,retain) IBOutlet UILabel *companyname;
@property (nonatomic,retain) IBOutlet UILabel *companyfans;
@property (nonatomic,retain) IBOutlet UIButton *subscribebtn;
@property (nonatomic,retain) IBOutlet UIScrollView *scrollview;
@property (nonatomic,retain) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSArray * serviceimages;
@property (nonatomic,strong) NSArray * servicetexts;

@end
