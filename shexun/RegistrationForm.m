//
//  RegistrationForm.m
//  BasicExample
//
//  Created by Nick Lockwood on 04/03/2014.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
//

#import "RegistrationForm.h"


@implementation RegistrationForm

//because we want to rearrange how this form
//is displayed, we've implemented the fields array
//which lets us dictate exactly which fields appear
//and in what order they appear

- (NSArray *)fields
{
    return @[
             
             //we want to add a group header for the field set of fields
             //we do that by adding the header key to the first field in the group
             
             @{FXFormFieldKey: @"nickname", FXFormFieldTitle:@"昵称",FXFormFieldHeader: @"注册信息"},
             
             //we don't need to modify these fields at all, so we'll
             //just refer to them by name to use the default settings
             @{FXFormFieldKey: @"name",FXFormFieldTitle: @"账号",
               @"textField.autocapitalizationType": @(UITextAutocapitalizationTypeWords)},
             
             @{FXFormFieldKey:@"password",FXFormFieldTitle:@"密码",FXFormFieldType:FXFormFieldTypePassword},
             @{FXFormFieldKey:@"repeatPassword",FXFormFieldTitle:@"确认密码",FXFormFieldType:FXFormFieldTypePassword},
             
             //we want to add another group header here, and modify the auto-capitalization
             
            
             
             
             //some more regular fields
             
             
             @{FXFormFieldKey:@"phone",FXFormFieldTitle:@"手机号码"},
             @{FXFormFieldTitle: @"获取验证码", FXFormFieldAction: @"sendVerifyCode:"},
             @{FXFormFieldKey:@"verifycode",FXFormFieldTitle:@"验证码"},
             //@{FXFormFieldKey:@"profilePhoto",FXFormFieldTitle:@"头像",FXFormFieldType:FXFormFieldTypeImage},
             
             
             @{FXFormFieldTitle: @"注册", FXFormFieldHeader: @"", FXFormFieldAction: @"submitRegistrationForm:"},
             
             ];
}

@end
