//
//  CompanyViewController.m
//  
//
//  Created by baoyuan on 15/11/3.
//
//

#import "CompanyViewController.h"
#import "CompanyCardViewController.h"
#import "CompanyActivityViewController.h"
#import "CompanyServiceViewController.h"
#import "CompanyHeader.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController

-(instancetype)init
{
    // Do any additional setup after loading the view.
    CompanyActivityViewController *activitytable = [[CompanyActivityViewController alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CompanyServiceViewController *servicecollection = [storyboard instantiateViewControllerWithIdentifier:@"companyservice"];
    CompanyCardViewController  *cardtable = [[CompanyCardViewController alloc]init];
    
    
    self = [super initWithControllers:activitytable,servicecollection,cardtable, nil];
    if (self) {
        // your code
        self.segmentMiniTopInset = 0;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)customHeaderView
{
    CompanyHeader *view = [[[NSBundle mainBundle] loadNibNamed:@"CompanyHeader" owner:nil options:nil] lastObject];
    view.backgroundColor = [UIColor redColor];
    return view;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
