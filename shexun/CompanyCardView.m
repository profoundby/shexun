//
//  CompanyCardView.m
//  shexun
//
//  Created by mac on 15-11-6.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CompanyCardView.h"

@implementation CompanyCardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(CompanyCardView *)initview
{
    CompanyCardView *cardview = [[NSBundle mainBundle] loadNibNamed:@"CompanyCardView" owner:self options:nil][0];
    return cardview;
}

@end
