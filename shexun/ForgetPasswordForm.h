//
//  ForgetPasswordForm.h
//  shexun
//
//  Created by mac on 15-10-21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"

@interface ForgetPasswordForm : NSObject<FXForm>


@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *verifycode;
@property (nonatomic, copy) NSString *repeatPassword;
@property (nonatomic, copy) NSString *password;



@property (nonatomic, copy) NSString *notifications;

@property (nonatomic, assign) BOOL agreedToTerms;

@end
