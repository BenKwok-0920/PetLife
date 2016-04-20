//
//  TitleNavigation.h
//  PetLife
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonAction)(int index);

@interface TitleNavigation : UIView
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;

@property (nonatomic,copy)buttonAction btnAction;

+(instancetype)defaultManager;

-(void)changeTextColorWith:(NSInteger)index;

@end
