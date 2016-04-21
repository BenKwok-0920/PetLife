//
//  MainModel.m
//  PetLife
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.mainID = [NSString stringWithFormat:@"%@",value];
    }
}

@end
