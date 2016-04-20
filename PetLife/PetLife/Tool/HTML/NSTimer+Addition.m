//
//  NSTimer+Addition.m
//  Leisure
//
//  Created by lanou3g on 16/4/5.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)

//暂停

-(void)pauseTimer{
    
    if (![self isValid]) {//判断当前的timer是否有效
        return;
    }
    
    [self setFireDate:[NSDate distantFuture]];
}

//继续

-(void)resumeTimer{

    if (![self isValid]) {//判断当前的timer是否有效
        return;
    }
    
    [self setFireDate:[NSDate date]];
}

//在多长时间以后继续执行

-(void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval{
    
    if (![self isValid]) {//判断当前的timer是否有效
        return;
    }
    
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
    
}

@end
