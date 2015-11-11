//
//  CompanyViewController.h
//  
//
//  Created by baoyuan on 15/11/3.
//
//
#import <UIKit/UIKit.h>
#import "CompanyCardView.h"
#import "CompanyActivityView.h"
#import "CompanyActivityTableViewCell.h"

@interface CompanyViewController :UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) IBOutlet UIImageView *companylogo;
@property (nonatomic,retain) IBOutlet UILabel *companyname;
@property (nonatomic,retain) IBOutlet UILabel *companyfans;
@property (nonatomic,retain) IBOutlet UIButton *subscribebtn;
@property (nonatomic,retain) IBOutlet UIScrollView *scrollview;
@property (nonatomic,retain) IBOutlet UICollectionView *collectionView;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segment;

@property (nonatomic,weak) NSDictionary *company;

@property (nonatomic,retain) CompanyCardView *cardview;
@property (nonatomic,retain) CompanyActivityView *activityview;

@property (nonatomic,strong) NSArray * serviceimages;
@property (nonatomic,strong) NSArray * servicetexts;
@property (nonatomic,copy)  NSArray * companyactivities;

@property (nonatomic, strong) CompanyActivityTableViewCell *prototypeCell;

-(void)openWebpage:(id)sender;
-(void)openDialpage:(id)sender;

@end
