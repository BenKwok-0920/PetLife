//
//  TitleNavigation.m
//  PetLife
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "TitleNavigation.h"

@implementation TitleNavigation

+(instancetype)defaultManager{

    static TitleNavigation *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TitleNavigation alloc] init];
    });
    
    return manager;
}

-(void)changeTextColorWith:(NSInteger)index{

    UIView *temp = self.subviews.lastObject;
    
    for (UIButton *button in temp.subviews) {
        
        button.titleLabel.textColor = [UIColor blackColor];
    }
    
    UIButton *btn = (UIButton *)[self viewWithTag:20001 + index];
    btn.titleLabel.textColor = [UIColor blueColor];
    
}

@end
