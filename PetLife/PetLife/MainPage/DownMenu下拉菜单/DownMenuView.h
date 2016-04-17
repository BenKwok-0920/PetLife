//
//  DownMenuView.h
//  PetLife
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownMenuView : UIView



+ (instancetype)menu;

//显示
- (void)showFrom:(UIView *)from;
//销毁
- (void)dismiss;

//内容
@property (nonatomic,strong)UIView *content;

//内容容器
@property (nonatomic,strong)UIViewController *contentController;

@end
