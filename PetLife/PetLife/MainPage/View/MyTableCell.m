//
//  MyTableCell.m
//  PetLife
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "MyTableCell.h"

@implementation MyTableCell

- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 8, 4, 20)];
        view.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:view];
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, ScreenWidth - 16, 20)];

        self.titleLabel.font = [UIFont systemFontOfSize:14];
//        self.myImg1 = [[MyImage alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(self.titleLabel.frame) + 8, (ScreenWidth - 24) / 2, 125)];
        self.myImg1 = [[[NSBundle mainBundle] loadNibNamed:@"MyImage" owner:nil options:nil] lastObject];
        self.myImg1.frame = CGRectMake(8, CGRectGetMaxY(self.titleLabel.frame) + 8, (ScreenWidth - 24) / 2, 125);

        
        self.myImg2 = [[[NSBundle mainBundle] loadNibNamed:@"MyImage" owner:nil options:nil] lastObject];
        self.myImg2.frame = CGRectMake(CGRectGetMaxX(self.myImg1.frame)+8, CGRectGetMaxY(self.titleLabel.frame) + 8, (ScreenWidth - 24) / 2, 125);
//        self.myImg2 = [[MyImage alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.myImg1.frame)+8, CGRectGetMaxY(self.titleLabel.frame) + 8, (ScreenWidth - 24) / 2, 125)];

        
//        self.myImg3 = [[MyImage alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(self.myImg1.frame) + 8, (ScreenWidth - 24) / 2, 125)];
        self.myImg3 = [[[NSBundle mainBundle] loadNibNamed:@"MyImage" owner:nil options:nil] lastObject];
        self.myImg3.frame = CGRectMake(8, CGRectGetMaxY(self.myImg1.frame) + 8, (ScreenWidth - 24) / 2, 125);

        
//        self.myImg4 = [[MyImage alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.myImg3.frame)+8, CGRectGetMaxY(self.myImg2.frame) + 8, (ScreenWidth - 24) / 2, 125)];
        self.myImg4 = [[[NSBundle mainBundle] loadNibNamed:@"MyImage" owner:nil options:nil] lastObject];
        self.myImg4.frame = CGRectMake(CGRectGetMaxX(self.myImg3.frame)+8, CGRectGetMaxY(self.myImg2.frame) + 8, (ScreenWidth - 24) / 2, 125);

        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.myImg1];
        [self.contentView addSubview:self.myImg2];
        [self.contentView addSubview:self.myImg3];
        [self.contentView addSubview:self.myImg4];


    }
    return self;
}

@end
