//
//  DatabaseManager.h
//  PetLife
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FMDB.h>

@interface DatabaseManager : NSObject

@property (nonatomic,strong)FMDatabase *database;

+(instancetype)defaultManager;

@end
