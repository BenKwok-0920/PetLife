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

-(instancetype)init{
    [self.firstButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.secondButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.thirdButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return self;
}

-(void)changeTextColorWith:(NSInteger)index{

    UIView *temp = [self viewWithTag:10000];
    
    for (UIButton *button in temp.subviews) {
        
        button.titleLabel.textColor = [UIColor blackColor];
        button.tintColor = [UIColor colorWithRed:0.098 green:0.098 blue:0.098 alpha:1.0];
    }
    
    UIButton *btn = (UIButton *)[self viewWithTag:20001 + index];
//    btn.backgroundColor = [UIColor blueColor];
//    btn.titleLabel.textColor = [UIColor colorWithRed:0.0 green:0.3804 blue:1.0 alpha:1.0];
    btn.tintColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000];
}

-(void)buttonAction:(UIButton *)sender{

    int a = (int)(sender.tag - 20001);
    self.btnAction(a);
//    [self changeTextColorWith:a];
//    sender.titleLabel.textColor = [UIColor blueColor];
}
- (IBAction)firstButton:(UIButton *)sender {
    int a = (int)(sender.tag - 20001);
    self.btnAction(a);
//    [self changeTextColorWith:a];
//    sender.titleLabel.textColor = [UIColor blueColor];
}
- (IBAction)secondButton:(UIButton *)sender {
    int a = (int)(sender.tag - 20001);
    self.btnAction(a);
//    [self changeTextColorWith:a];
//    sender.titleLabel.textColor = [UIColor blueColor];
}
- (IBAction)thirdButton:(UIButton *)sender {
    int a = (int)(sender.tag - 20001);
    self.btnAction(a);
//    [self changeTextColorWith:a];
//    sender.titleLabel.textColor = [UIColor blueColor];
}

@end
