//
//  MySelfTableViewCell.m
//  PetLife
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "MySelfTableViewCell.h"

@implementation MySelfTableViewCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])  {
        
        self.imagBar = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.height - 16)/2,(self.frame.size.height - 16)/2, 16,16)];
        [self.contentView addSubview:_imagBar];
        
        self.labelBar = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imagBar.frame) + 10, 5, self.frame.size.width - (CGRectGetMaxX(self.imagBar.frame) + 10)  , self.frame.size.height - 10)];
        [self.contentView addSubview:_labelBar];
        
        self.huancun = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 70, 10, 50, 21)];
        self.huancun.textColor = [UIColor grayColor];
        self.huancun.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.huancun];
        
        
    }
    
    return self;
}

@end
