//
//  FirstViewController.m
//  shexun
//
//  Created by mac on 15-10-8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self.navigationController.navigationItem.leftBarButtonItem performSelector:(@selector(popleftmenu)) withObject:nil afterDelay:0];
    
}

- (void)popleftmenu{
    [(RESideMenuViewController *)self.navigationController.tabBarController.parentViewController presentLeftMenuViewController];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
