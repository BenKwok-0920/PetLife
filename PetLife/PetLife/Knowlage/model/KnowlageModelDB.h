//
//  KnowlageModelDB.h
//  PetLife
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KnowlageModel;

@interface KnowlageModelDB : NSObject

-(void)createTable;

-(NSArray *)selectAlldataWithTableID:(int)tableID;

-(void)insertDataWithModel:(KnowlageModel *)model andTableID:(int)tableID;

-(void)deleteAllDataWithTableID:(int)tableID;


@end
