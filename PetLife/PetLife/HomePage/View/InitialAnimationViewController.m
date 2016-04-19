//
//  InitialAnimationViewController.m
//  PetLife
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "InitialAnimationViewController.h"
#define VWidth self.view.bounds.size.width
#define SvWidth self.scrollView.bounds.size.width
#define SvHeight self.scrollView.bounds.size.height
#define OFFsetX self.scrollView.contentOffset.x


@interface InitialAnimationViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;

@end

@implementation InitialAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma mark -设置scrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake((VWidth - 300) / 2, 70, 300, 418)];
#pragma mark -将图片添加到scrollview上
    for (int i = 0; i < 3; i++) {
        //接收图片
        NSString *stringImage = [NSString stringWithFormat:@"mengchong_%d",i+1];
        //设置图片的尺寸
        UIImageView *imageOA = [[UIImageView alloc]initWithFrame:CGRectMake(SvWidth *i,0,SvWidth , SvHeight)];
        
        imageOA.image = [UIImage imageNamed:stringImage];
        
        [self.scrollView addSubview:imageOA];
    }
    
    [self.view addSubview:self.scrollView];
#pragma mark -设置scrollView的属性
    //设置滚动区间
    self.scrollView.contentSize = CGSizeMake(SvWidth* 3, 0);
    //设置分页
    self.scrollView.pagingEnabled = YES;
    ///隐藏分页滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;

    self.scrollView.delegate = self;
    
    //创建一个NSTime
    //每隔多长时间调用一次设置的方法
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
}

-(void)scrollImage{
    //1.获取当前page的页码
    NSInteger page = self.pageControl.currentPage;
    //2.判断图片是否到了最后一页(返回第一页)  不是则+1；
    if (page == self.pageControl.numberOfPages - 1) {
        page = 0;//返回第一页
    }else{
        page++;
    }
    //3.计算出下一页的contentOffset.x
    CGFloat offsetX = page * SvWidth;
    //4.设置偏移量
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
