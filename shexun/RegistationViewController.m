//
//  RegistationViewController.m
//  shexun
//
//  Created by mac on 15-10-15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "RegistationViewController.h"
#import "RegistrationForm.h"
#import "AFUtil.h"
#import "ServerAPI.h"

@implementation RegistationViewController

- (void)awakeFromNib
{
    //set up form
    self.formController.form = [[RegistrationForm alloc] init];
}

- (void)submitRegistrationForm:(UITableViewCell<FXFormFieldCell> *)cell
{
    RegistrationForm *form = cell.field.form;
    if (![form.password isEqualToString:form.repeatPassword]) {
        [[[UIAlertView alloc] initWithTitle:@"两次密码输入不一致" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }
    else
    {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        if(form.phone.length  == 0)
        {
            [[[UIAlertView alloc] initWithTitle:@"手机号码不能为空" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            return;
        }
        if(form.verifycode.length  == 0)
        {
            [[[UIAlertView alloc] initWithTitle:@"验证码不能为空" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            return;
        }
        if(form.password.length  == 0)
        {
            [[[UIAlertView alloc] initWithTitle:@"密码不能为空" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            return;
        }
        
        
        [params setObject:form.phone forKey:@"mobile"];
        [params setObject:form.verifycode forKey:@"code"];
        [params setObject:form.password forKey:@"password"];
        [params setObject:form.nickname forKey:@"nickname"];
        [params setObject:form.name forKey:@"username"];
        
        [AFUtil postJSONWithUrl:[NSString stringWithFormat:@"%@%@",SERVER_PREFIX,SX_REGISTER] parameters:params  success:^(id json) {
            if ([[json objectForKey:@"status"] integerValue] == 200) {
                NSLog(@"%@",json);
                [[[UIAlertView alloc] initWithTitle:[[json objectForKey:@"result"] objectForKey:@"info"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            }
            else {
                [[[UIAlertView alloc] initWithTitle:[[json objectForKey:@"result"] objectForKey:@"info"]message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            }
        } fail:^{
            [[[UIAlertView alloc] initWithTitle:@"数据获取失败，请稍后重试" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        }];
    }

}

- (void)sendVerifyCode:(UIButton *) button
{
    RegistrationForm *form = self.formController.form;
    if([AFUtil checkPhoneNumInput:form.phone])
    {
        [AFUtil JSONDataWithUrl:[NSString stringWithFormat:@"%@%@",SERVER_PREFIX,SX_AUTHCODE] success:^(id json) {
              [[[UIAlertView alloc] initWithTitle:[json objectForKey:@"result"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            
        } fail:^{
               [[[UIAlertView alloc] initWithTitle:@"服务器数据获取失败" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        }];
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"手机号码不正确" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }
}


@end
