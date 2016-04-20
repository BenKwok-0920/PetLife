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
        
        button.titleLabel.textColor = [UIColor redColor];
        button.tintColor = [UIColor redColor];
//        button.backgroundColor = [UIColor   greenColor];
    }
    
    UIButton *btn = (UIButton *)[self viewWithTag:20001 + index];
//    btn.backgroundColor = [UIColor blueColor];
    btn.titleLabel.textColor = [UIColor blueColor];
    
}

-(void)buttonAction:(UIButton *)sender{

    int a = (int)(sender.tag - 20001);
    self.btnAction(a);
    [self changeTextColorWith:a];
    sender.titleLabel.textColor = [UIColor blueColor];
}
- (IBAction)firstButton:(UIButton *)sender {
    int a = (int)(sender.tag - 20001);
    self.btnAction(a);
    [self changeTextColorWith:a];
    sender.titleLabel.textColor = [UIColor blueColor];
}
- (IBAction)secondButton:(UIButton *)sender {
    int a = (int)(sender.tag - 20001);
    self.btnAction(a);
    [self changeTextColorWith:a];
    sender.titleLabel.textColor = [UIColor blueColor];
}
- (IBAction)thirdButton:(UIButton *)sender {
    int a = (int)(sender.tag - 20001);
    self.btnAction(a);
    [self changeTextColorWith:a];
    sender.titleLabel.textColor = [UIColor blueColor];
}

@end
