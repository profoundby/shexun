//
//  CommunityViewController.m
//  shexun
//
//  Created by mac on 15-11-6.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CommunityViewController.h"
#import <MBProgressHUD.h>

@interface CommunityViewController ()

@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.shexun.net.cn/index.php?m=content&c=index&a=lists&catid=217"]]];
    [self.webview setScalesPageToFit:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
