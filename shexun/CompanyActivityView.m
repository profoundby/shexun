//
//  CompanyActivityView.m
//  
//
//  Created by baoyuan on 15/11/8.
//
//

#import "CompanyActivityView.h"

@implementation CompanyActivityView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(CompanyActivityView *)initview
{
    CompanyActivityView *activityView = [[NSBundle mainBundle] loadNibNamed:@"CompanyActivityView" owner:self options:nil][0];
    return activityView;
}

@end
