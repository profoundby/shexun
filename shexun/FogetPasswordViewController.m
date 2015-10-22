//
//  FogetPasswordViewController.m
//  shexun
//
//  Created by mac on 15-10-21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "FogetPasswordViewController.h"
#import "ForgetPasswordForm.h"

@implementation FogetPasswordViewController


- (void)awakeFromNib
{
    //set up form
    self.formController.form = [[ForgetPasswordForm alloc] init];
}

- (void)submitRegistrationForm:(UITableViewCell<FXFormFieldCell> *)cell
{
    //we can lookup the form from the cell if we want, like this:
    ForgetPasswordForm *form = cell.field.form;

    
    //we can then perform validation, etc
    if (form.agreedToTerms)
    {
        [[[UIAlertView alloc] initWithTitle:@"Registration Form Submitted" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"User Error" message:@"Please agree to the terms and conditions before proceeding" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Yes Sir!", nil] show];
    }
}

- (void)sendVerifyCode:(UIButton *) button
{
    NSLog(@"send verify code");
}


@end
