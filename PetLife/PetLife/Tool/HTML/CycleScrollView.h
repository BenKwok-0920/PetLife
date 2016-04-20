//
//  CycleScrollView.h
//  Leisure
//
//  Created by lanou3g on 16/4/5.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIView *(^FetchContentViewAtIndex)(NSInteger pageIndex);

typedef void(^TapActionBlock)(NSInteger pageIndex);
@interface CycleScrollView : UIView

//页面图片的个数

@property (nonatomic,assign)NSInteger totalPageCont;

//刷新视图block

@property (nonatomic,copy)FetchContentViewAtIndex  fetchContentViewAtIndex;

//点击页面

@property (nonatomic,copy)TapActionBlock tapActionBlock;

//初始化方法

-(id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

@end
