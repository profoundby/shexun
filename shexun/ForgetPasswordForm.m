//
//  ForgetPasswordForm.m
//  shexun
//
//  Created by mac on 15-10-21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ForgetPasswordForm.h"

@implementation ForgetPasswordForm

- (NSArray *)fields
{
    return @[
             
             //we want to add a group header for the field set of fields
             //we do that by adding the header key to the first field in the group
             
             @{FXFormFieldKey:@"phone",FXFormFieldTitle:@"手机号码",FXFormFieldHeader: @"忘记密码"},
             @{FXFormFieldTitle: @"获取验证码", FXFormFieldAction: @"sendVerifyCode:"},
             @"验证码",
             
             //we don't need to modify these fields at all, so we'll
             //just refer to them by name to use the default settings
             @{FXFormFieldKey: @"name",FXFormFieldTitle: @"账号",
               @"textField.autocapitalizationType": @(UITextAutocapitalizationTypeWords)},
             
             @{FXFormFieldKey:@"password",FXFormFieldTitle:@"密码",FXFormFieldType:FXFormFieldTypePassword},
             @{FXFormFieldKey:@"repeatpassword",FXFormFieldTitle:@"确认密码",FXFormFieldType:FXFormFieldTypePassword},
             
             
             @{FXFormFieldTitle: @"修改密码", FXFormFieldHeader: @"", FXFormFieldAction: @"submitRegistrationForm:"},
             
             ];
}


@end
