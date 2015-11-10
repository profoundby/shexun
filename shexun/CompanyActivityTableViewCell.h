//
//  CompanyActivityTableViewCell.h
//  
//
//  Created by baoyuan on 15/11/10.
//
//

#import <UIKit/UIKit.h>

@interface CompanyActivityTableViewCell : UITableViewCell

@property (nonatomic,retain) IBOutlet UIImageView *companylogo;
@property (nonatomic,retain) IBOutlet UILabel *companyname;
@property (nonatomic,retain) IBOutlet UILabel *activitytitle;
@property (nonatomic,retain) IBOutlet UILabel *activitycontent;

@end
