//
//  LoginViewController.m
//  shexun
//
//  Created by mac on 15-10-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "AFUtil.h"
#import "ServerAPI.h"
#import <MBProgressHUD.h>
#import "RESideMenuViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.recordpass addTarget:self action:@selector(recordpassDidChange:) forControlEvents:UIControlEventValueChanged];
    self.recordpass.textLabel.text = @"记住密码";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"recordpass"] isEqualToString:@"1"]) {
        [self.username setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
        [self.password setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]];
        self.recordpass.checked = YES;
    }
    [self recordpassDidChange:self.recordpass];
    [self.autologin addTarget:self action:@selector(autologinDidChange:) forControlEvents:UIControlEventValueChanged];
    self.autologin.textLabel.text = @"自动登录";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"1"]) {
        self.autologin.checked = YES;
        [self loginAction:nil];
    }
    [self autologinDidChange:self.autologin];
  

}

- (void)recordpassDidChange:(CTCheckbox *)checkbox
{
    if (checkbox.checked) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"recordpass"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"recordpass"];
    }
}

- (void)autologinDidChange:(CTCheckbox *)checkbox
{
    if (checkbox.checked) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"autologin"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"autologin"];
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

-(IBAction)loginAction:(id)sender
{
    if (self.username.text.length == 0 || self.password.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名或者密码不能为空" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }
    else
    {
        NSMutableDictionary *logindic = [[NSMutableDictionary alloc] initWithCapacity:2];
        [logindic setObject:self.username.text forKey:@"username"];
        [logindic setObject:self.password.text forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] setObject:self.username.text  forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:self.password.text  forKey:@"password"];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //hud.mode = MBProgressHUDModeText;
        hud.labelText = @"正在登录";
        [AFUtil postJSONWithUrl:[NSString stringWithFormat:@"%@%@",SERVER_PREFIX,SX_LOGIN] parameters:logindic success:^(id responseObject)
         {
             [hud hide:YES];
             NSLog(@"%@",[responseObject objectForKey:@"result"]);
             if([[responseObject objectForKey:@"status"]  integerValue] == 400)
             {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:[responseObject objectForKey:@"result"]  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alert show];
             }
             else
             {
             [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"result"] forKey:@"userinfo"];
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
             RESideMenuViewController *residevc = (RESideMenuViewController *)[storyboard instantiateViewControllerWithIdentifier:@"sidebarviewcontroller"];
             [self presentViewController:residevc animated:NO completion:nil];
             }
             
         }fail:^(void)
         {
             [hud hide:YES];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alert show];
             
         }];
    }
}

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

-(void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

@end
