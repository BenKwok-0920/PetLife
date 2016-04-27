//
//  DatabaseManager.m
//  PetLife
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

+(instancetype)defaultManager{

    static DatabaseManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DatabaseManager alloc] init];
    });
    
    return manager;
}

-(instancetype)init{
    if (self = [super init]) {
        
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [documentPath stringByAppendingPathComponent:@"knowledge.sqlite"];
        NSLog(@"filePath = %@",filePath);
        self.database = [[FMDatabase alloc] initWithPath:filePath];
        BOOL isOpen = [self.database open];
        if (!isOpen) {
            NSLog(@"打开数据库失败！");
        }
    }

    return self;
}


@end
