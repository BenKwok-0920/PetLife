//
//  NSTimer+Addition.h
//  Leisure
//
//  Created by lanou3g on 16/4/5.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

//暂停

-(void)pauseTimer;

//继续

-(void)resumeTimer;

//在多长时间以后继续执行

-(void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
