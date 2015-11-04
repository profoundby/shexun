//
//  CompanyServiceViewControllerCollectionViewController.h
//  
//
//  Created by baoyuan on 15/11/3.
//
//

#import <UIKit/UIKit.h>
#import <ARSegmentPageController.h>

@interface CompanyServiceViewController : UICollectionViewController<ARSegmentControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSArray * serviceimages;
@property (nonatomic,strong) NSArray * servicetexts;

@end
