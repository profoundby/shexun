//
//  AFUtil.h
//  shexun
//
//  Created by mac on 15-10-13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface AFUtil : NSObject

+ (void)JSONDataWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)())fail;
+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;
+ (BOOL)checkPhoneNumInput:(NSString *)phoneNum;
+ (NSString *)removeHTML:(NSString *)html ;
@end
