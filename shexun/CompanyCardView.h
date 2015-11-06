//
//  CompanyCardView.h
//  shexun
//
//  Created by mac on 15-11-6.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyCardView : UIView

@property (nonatomic,retain) IBOutlet UILabel *introduce;
@property (nonatomic,retain) IBOutlet UILabel *website;
@property (nonatomic,retain) IBOutlet UILabel *tel;
@property (nonatomic,retain) IBOutlet UILabel *address;



+(CompanyCardView *)initview;

@end
