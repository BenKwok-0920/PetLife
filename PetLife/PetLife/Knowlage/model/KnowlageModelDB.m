//
//  KnowlageModelDB.m
//  PetLife
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "KnowlageModelDB.h"
#import "FMDB.h"
#import "DatabaseManager.h"
#import "KnowlageModel.h"

@interface KnowlageModelDB ()

@property (nonatomic,strong)FMDatabase *database;
//@property (nonatomic,strong)NSInteger

@end

@implementation KnowlageModelDB

-(instancetype)init{
    
    if (self = [super init]) {
        self.database = [DatabaseManager defaultManager].database;
    }

    return self;
}

-(void)createTable{
    
    NSString *createSQL = [NSString stringWithFormat:@"create table if not exists knowlageTable(tableID NSInteger,title text,contents text,image text,number NSInteger)"];
    BOOL isCreate = [self.database executeUpdate:createSQL];
    if (isCreate) {
        NSLog(@"创建表成功！");
    }else{
    
        NSLog(@"创建表失败！");
    }
}

-(NSArray *)selectAlldataWithTableID:(int)tableID{
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *selectSQL = [NSString stringWithFormat:@"select * from knowlageTable where tableID = %d",tableID];
    
    FMResultSet *set = [self.database executeQuery:selectSQL];
    
    while ([set next]) {
        
        KnowlageModel *model = [[KnowlageModel alloc] init];
        model.title = [set stringForColumn:@"title"];
        model.brief = [set stringForColumn:@"contents"];
        model.img = [set stringForColumn:@"image"];
        model.number = [NSNumber numberWithInt:[set intForColumn:@"number"]];
        
        [array addObject:model];
    }
    
    
    return array;
}

-(void)insertDataWithModel:(KnowlageModel *)model andTableID:(int)tableID{

    NSString *insertIntoSQL = [NSString stringWithFormat:@"insert into knowlageTable(tableID,title,contents,image,number)values(%d,'%@','%@','%@',%d) ",tableID,model.title,model.brief,model.img,model.number.intValue];
    BOOL isInsert = [self.database executeUpdate:insertIntoSQL];
    if (isInsert) {
        NSLog(@"数据插入成功！");
    }else{
    
        NSLog(@"数据插入失败！");
    }
}

-(void)deleteAllDataWithTableID:(int)tableID{
    
    NSString *delectSQL = [NSString stringWithFormat:@"delete from knowlageTable where tableID = %d",tableID];
    BOOL isDelete = [self.database executeUpdate:delectSQL];
    
    if (isDelete) {
        
        NSLog(@"数据删除成功！");
        
    }else{
    
        NSLog(@"数据删除失败！");
    }
    
}

@end
