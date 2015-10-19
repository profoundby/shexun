//
//  LoginViewController.m
//  shexun
//
//  Created by mac on 15-10-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.recordpass addTarget:self action:@selector(recordpassDidChange:) forControlEvents:UIControlEventValueChanged];
    self.recordpass.textLabel.text = @"记住密码";
    [self recordpassDidChange:self.recordpass];
    [self.autologin addTarget:self action:@selector(autologinDidChange:) forControlEvents:UIControlEventValueChanged];
    self.autologin.textLabel.text = @"自动登录";
    [self autologinDidChange:self.recordpass];

}

- (void)recordpassDidChange:(CTCheckbox *)checkbox
{
    if (checkbox.checked) {
       
    } else {
        
    }
}

- (void)autologinDidChange:(CTCheckbox *)checkbox
{
    if (checkbox.checked) {
        
    } else {
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

-(void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

@end
