//
//  NetRequestManager.h
//  PetLife
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

// 定义枚举 用来表示请求类型
typedef NS_ENUM(NSUInteger, RequestType) {
    GET,
    POST,
};

// 网络请求完成的block
typedef void(^RequestFinish)(NSData *data);

// 网络请求失败的block
typedef void(^RequestError)(NSError *error);

@interface NetRequestManager : NSObject

+ (void)requestWithType:(RequestType)type URLString:(NSString *)URL parDic:(NSDictionary *)parDic finish:(RequestFinish)finish error:(RequestError)error;

@end
