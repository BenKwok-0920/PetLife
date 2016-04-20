//
//  KnowlageTableViewCell.m
//  PetLife
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "KnowlageTableViewCell.h"
#import "KnowlageModel.h"
#import <UIImageView+WebCache.h>

@implementation KnowlageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataWithModel:(KnowlageModel *)model{

    _contentLabel.text = model.brief;
    _titleLabel.text = model.title;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
}

@end
