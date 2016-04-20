//
//  CycleScrollView.m
//  Leisure
//
//  Created by lanou3g on 16/4/5.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"

@interface CycleScrollView ()<UIScrollViewDelegate>

//基础视图
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;

//存储内容的数组
@property (nonatomic,strong)NSMutableArray *contentViews;
//定时器
@property (nonatomic,strong)NSTimer *animationTimer;
@property (nonatomic,assign)NSTimeInterval animationTimeInterval;

//当前页
@property (nonatomic,assign)NSInteger currentPageIndex;


@end

@implementation CycleScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.autoresizesSubviews = YES;//设置子视图自动调整
        
        self.currentPageIndex = 0;// 默认当前页为第一页
        
        //创建scrollview
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
        self.scrollView.autoresizingMask = 0xFF;
        
        self.scrollView.contentMode = UIViewContentModeCenter;
        
        self.scrollView.contentSize = CGSizeMake(3*CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        
        self.scrollView.delegate = self;
        
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        
        self.scrollView.bounces = NO;
        
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:self.scrollView];
        
        //创建pagecontroll
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width - 100, self.bounds.size.height - 35, 100, 35)];
        
        [self addSubview:self.pageControl];
    }
    
    return self;
}


-(id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration{
    
    self = [self initWithFrame:frame];
    if (animationDuration >0.0) {
        
        //创建定时器对象 传入参数
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:animationDuration target:self selector:@selector(animationTimerDidFired:) userInfo:nil repeats:YES];
        
        [self.animationTimer pauseTimer];
    }
    
    
    
    return self;

}

#pragma mark  定时器方法
-(void)animationTimerDidFired:(NSTimer *)timer{
    
    //滚动到下一页
    CGPoint newPoint = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), 0);
    
    [self.scrollView setContentOffset:newPoint];
    
}

//获取下一页

-(NSInteger)getNextPageIndex:(NSInteger)currentPageIndex{
    
    if (currentPageIndex == -1) {//从首页到尾页
        return self.totalPageCont - 1;
    }else if (currentPageIndex == self.totalPageCont){//从尾页到首页
    
        return 0;
    }
    else{//中间情况
    
        return currentPageIndex;
    }
    
}

//页面总数set
-(void)setTotalPageCont:(NSInteger)totalPageCont{

    _totalPageCont = totalPageCont;
    
    if (_totalPageCont > 0) {
        
        //配置内容
        [self configContewntView];
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationTimeInterval];
        _pageControl.numberOfPages = _totalPageCont;
    }
}

//设置scrollview的内容  只处理要显示内容的数组
-(void)setScrollViewContentData{

    if (self.contentViews == nil) {
        
        self.contentViews = [@[] mutableCopy];
        
    }
    
    [self.contentViews removeAllObjects];
    //获取前一个位置和后一个位置
    NSInteger beforePageIndex = [self getNextPageIndex:self.currentPageIndex - 1];
    NSInteger afterPageIndex = [self getNextPageIndex:self.currentPageIndex + 1];
    //根据位置获取视图  使用bolock 在VC里面进行复制
    if (self.fetchContentViewAtIndex) {
        
        [self.contentViews addObject:self.fetchContentViewAtIndex(beforePageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(afterPageIndex)];
        
    }
    
}

//配置内容页面
-(void)configContewntView{

    //移除掉所有的子视图
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //设置scrollview的内容
    [self setScrollViewContentData];
    
    //记录当前视图位置
    NSInteger count = 0;
    //按顺序添加新的视图
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        
        //添加手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (count++), 0);
        //设置位置
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
        
    }
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    
}

//手势单击调用block

-(void)contentViewTapAction:(UITapGestureRecognizer *)sender{
    
    if (self.tapActionBlock) {
        
        self.tapActionBlock(self.currentPageIndex);
        
    }
    
}


#pragma mark scrollviewdelegate
//支持拖拽

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{

    //停止定时器  避免手势与定时器的冲突
    
    [self.animationTimer pauseTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self.animationTimer resumeTimerAfterTimeInterval:self.animationTimeInterval];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    int contentOffSetX = scrollView.contentOffset.x;
    if (contentOffSetX >= 2 * CGRectGetWidth(scrollView.frame)) {
        self.currentPageIndex = [self getNextPageIndex:self.currentPageIndex + 1];
        
        [self configContewntView];
    }
    if (contentOffSetX <= 0 ) {
        
        self.currentPageIndex = [self getNextPageIndex:self.currentPageIndex - 1];
        
        [self configContewntView];
    }
    
    _pageControl.currentPage = self.currentPageIndex;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

@end
