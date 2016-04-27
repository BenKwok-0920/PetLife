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

@interface KnowlageHeader ()

@property (nonatomic,assign)NSNumber* number;

@end

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
    
    _imgImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_imgImageView addGestureRecognizer:tap];
    self.number = model.number;
}

-(void)tapAction:(UITapGestureRecognizer *)sender{

    if (self.tapActionSkip) {
        self.tapActionSkip(self.number);
    }
    
}

@end
