//
//  NewsDetailViewController.m
//  shexun
//
//  Created by mac on 15-11-3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "AFUtil.h"
#import "ServerAPI.h"
#import <MBProgressHUD.h>

@implementation NewsDetailViewController

@synthesize titletext,newsid;

-(void)viewDidLoad
{
    [self.newstitle setText:titletext];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.mode = MBProgressHUDModeText;
    hud.labelText = @"正在获取新闻内容";
    [AFUtil JSONDataWithUrl:[NSString stringWithFormat:@"%@%@&newsid=%@",SERVER_PREFIX,SX_NEWSDETAIL,newsid] success:^(id json) {
        [hud hide:YES];
        [self.contentWebview loadHTMLString:[[json objectForKey:@"result"] objectForKey:@"content"] baseURL:nil];
    } fail:^{
        [hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=380;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.height * (maxwidth/oldwidth)*2;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}

@end
