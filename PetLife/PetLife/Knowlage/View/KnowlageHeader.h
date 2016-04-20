//
//  KnowlageHeader.h
//  PetLife
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KnowlageModel;
@interface KnowlageHeader : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


-(void)setDataWithModel:(KnowlageModel *)model;

@end
