//
//  KnowlageHeader.m
//  PetLife
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "KnowlageHeader.h"
#import "KnowlageModel.h"
#import <UIImageView+WebCache.h>

@implementation KnowlageHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setDataWithModel:(KnowlageModel *)model{

    [_imgImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    _titleLabel.text = model.title;
}


@end
