//
//  CellModel.h
//  PetLife
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "BaseModel.h"

@class ItemModel;

@interface CellModel : BaseModel

@property (nonatomic,strong)NSString *title;

@property (nonatomic,strong)ItemModel *data;

@end
