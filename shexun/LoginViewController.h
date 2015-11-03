//
//  LoginViewController.h
//  shexun
//
//  Created by mac on 15-10-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCheckbox.h"



@interface LoginViewController : UIViewController

@property (strong,nonatomic) IBOutlet CTCheckbox * recordpass;
@property (weak,nonatomic) IBOutlet CTCheckbox * autologin;
@property (nonatomic,retain) IBOutlet UITextField *username;
@property (nonatomic,retain) IBOutlet UITextField *password;

-(IBAction)loginAction:(id)sender;

@end
