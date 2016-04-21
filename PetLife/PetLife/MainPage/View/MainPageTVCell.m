//
//  MainPageTVCell.m
//  PetLife
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "MainPageTVCell.h"

@implementation MainPageTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, ScreenWidth - 30, 160)];
        self.titleImg.layer.masksToBounds = YES;
        self.titleImg.layer.cornerRadius = 10;
//        self.titleImg.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:self.titleImg];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.titleImg.frame) + 8, ScreenWidth - 60, 17)];
//        self.titleLabel.backgroundColor = [UIColor cyanColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.textColor = [UIColor grayColor];
        self.contentLabel.font = [UIFont systemFontOfSize:13];
//        self.contentLabel.backgroundColor = [UIColor cyanColor];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return self;
}

@end
