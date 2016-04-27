//
//  NetRequestManager.m
//  PetLife
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "NetRequestManager.h"

@implementation NetRequestManager

+ (void)requestWithType:(RequestType)type URLString:(NSString *)URL parDic:(NSDictionary *)parDic finish:(RequestFinish)finish error:(RequestError)error{
    
    NetRequestManager *manager = [[NetRequestManager alloc] init];
    [manager requestWithType:type URLString:URL parDic:parDic finish:finish error:error];
    
}

- (void)requestWithType:(RequestType)type URLString:(NSString *)URL parDic:(NSDictionary *)parDic finish:(RequestFinish)finish error:(RequestError)errorReq{
    
    NSURLCache *urlCaches = [NSURLCache sharedURLCache];
    
    [urlCaches setMemoryCapacity:500*1024*1024];
    
    NSURL *url = [NSURL URLWithString:URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    
    if (type == POST) {
        request.HTTPMethod = @"POST";
        
        if (parDic.count > 0) {
            NSData *data = [self parDicToDataWithDic:parDic];
            request.HTTPBody = data;
        }
        
    }
    
    // 从请求中获取缓存输出
    NSCachedURLResponse *response = [urlCaches cachedResponseForRequest:request];
    
    // 判断是否有缓存
    if (response != nil) {
        NSLog(@"有缓存,取缓存");
        [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }
    
    
    
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (data) {
                finish(data);
            }
            if (error) {
                errorReq(error);
            }
        }];
        
        [task resume];
}

- (NSData *)parDicToDataWithDic:(NSDictionary *)dic{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in dic.allKeys) {
        NSString *str = [NSString stringWithFormat:@"%@=%@",key,dic[key]];
        [array addObject:str];
    }
    NSString *parStr = [array componentsJoinedByString:@"&"];
    NSData *data = [parStr dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

@end
