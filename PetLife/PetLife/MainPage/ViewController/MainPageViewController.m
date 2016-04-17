//
//  FirstViewController.m
//  PetLife
//
//  Created by lanou3g on 16/4/14.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "MainPageViewController.h"
#import "DownMenuTableViewController.h"
#import "DownMenuView.h"
#import "NetRequestManager.h"
#import "ScrollModel.h"
#import <UIImageView+WebCache.h>
#import <SDCycleScrollView.h>

@interface MainPageViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong)NSMutableArray *scrollArray;

// 页面scrollView
@property (nonatomic,strong)UIScrollView *pageScroll;

//@property (nonatomic,strong)UIScrollView *scrollView;
//
//@property (nonatomic,strong)UIPageControl *pageControl;
//
//@property (nonatomic,strong)NSTimer *timer;

// 网络图片数组
@property (nonatomic,strong)NSMutableArray *imgArr;

// 滚动图标题数组
@property (nonatomic,strong)NSMutableArray *titArr;

@end

@implementation MainPageViewController

// 单例 scrollView的数组
- (NSMutableArray *)scrollArray{
    if (!_scrollArray) {
        _scrollArray = [NSMutableArray array];
    }
    return _scrollArray;
}

- (NSMutableArray *)imgArr{
    if (!_imgArr) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

- (NSMutableArray *)titArr{
    if (!_titArr) {
        _titArr = [NSMutableArray array];
    }
    return _titArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_editor_align_right"] style:(UIBarButtonItemStyleDone) target:self action:@selector(CDitemAction:)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavigationBarHeight)];
    self.pageScroll.contentSize = CGSizeMake(0, 1000);
    
    [self.view addSubview:self.pageScroll];
    
    [self requestData];
    
    
    
}

// 首页点击出现菜单的方法
- (void)CDitemAction:(id)sender {
    
    DownMenuView *downMenuView = [DownMenuView menu];
    
    DownMenuTableViewController *menu = [[DownMenuTableViewController alloc]init];
    menu.view.height = 150;
    menu.view.width = 120;
    downMenuView.contentController = menu;
    
    [downMenuView showFrom:sender];
    
    
}

- (void)requestData{
    // 请求数据
    [NetRequestManager requestWithType:GET URLString:MAINPAGE_URL parDic:nil finish:^(NSData *data) {
        
       // NSLog(@"data = %@",data);
        
        NSError *error = nil;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:&error];
        if (!error) {
            // 解析数据
            NSArray *arr = [dic objectForKey:@"data"];
            // arr 里面的第0个字典 就是scrollView的数据
            NSDictionary *scrollDic = arr[0];
            NSArray *scArr = [scrollDic objectForKey:@"data"];
            for (NSDictionary *scDic in scArr) {
                NSLog(@"创建model了");
                ScrollModel *model = [[ScrollModel alloc] init];
                [model setValuesForKeysWithDictionary:scDic];
                [self.scrollArray addObject:model];
                [self.imgArr addObject:model.img];
                [self.titArr addObject:model.text];
            }
            
            // 创建scrollView
            dispatch_async(dispatch_get_main_queue(), ^{
                [self createScrollView];
            });
            
            
            
        }else{
            NSLog(@"数据解析失败,error=%@",error);
        }
        
    } error:^(NSError *error) {
        NSLog(@"首页请求数据失败!!!%@",error);
    }];
}


- (void)createScrollView{
    /*
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, ScreenWidth, ImgHeight)];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * self.scrollArray.count, 0);
    self.scrollView.backgroundColor = [UIColor redColor];
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    self.scrollView.delegate = self;
    
    for (int i = 0; i < self.scrollArray.count; i++) {
        // 创建图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, ImgHeight)];
        imgView.backgroundColor = [UIColor blueColor];
        ScrollModel *scModel = self.scrollArray[i];
        NSLog(@"img = %@",scModel.img);
        [imgView sd_setImageWithURL:[NSURL URLWithString:scModel.img] placeholderImage:nil];
        
        // !!!:给每个ImgView添加手势
//        imgView.userInteractionEnabled = YES;
        
        [self.scrollView addSubview:imgView];
        NSLog(@"加了滚动的图片了");
        
        // 创建label
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(8, ImgHeight - 28, ScreenWidth - 100, 20)];
//        lab.backgroundColor = [UIColor blueColor];
        lab.text = scModel.text;
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:13];
        [imgView addSubview:lab];
    }
    
    
    // 创建pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(ScreenWidth - 100, NavigationBarHeight + ImgHeight - 28, 90, 20)];
    self.pageControl.numberOfPages = self.scrollArray.count;
    
    
    
    
    [self.pageScroll addSubview:self.scrollView];
    [self.pageScroll addSubview:self.pageControl];
    
    // 设置nstimer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(playScroll) userInfo:nil repeats:YES];
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
    */
    
    
    SDCycleScrollView *cycleScroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, NavigationBarHeight, ScreenWidth, ImgHeight) delegate:self placeholderImage:nil];
    cycleScroll.imageURLStringsGroup = self.imgArr;
    
    cycleScroll.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    cycleScroll.titlesGroup = self.titArr;
    
    cycleScroll.autoScrollTimeInterval = 3.5;
    
    cycleScroll.delegate = self;
    
    cycleScroll.pageControlDotSize = CGSizeMake(20, 20);
    
    
    [self.pageScroll addSubview:cycleScroll];
    
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}


/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (self.scrollView.contentOffset.x) / ScreenWidth;
}

// NSTimer执行的方法
- (void)playScroll{
    CGFloat offSet = self.scrollView.contentOffset.x;
    offSet += self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(offSet, 0) animated:YES];
    if (offSet == self.scrollArray.count * self.scrollView.frame.size.width) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}


// 拖拽的时候让NSTimer停止
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer setFireDate:[NSDate distantFuture]];
}

// 拖拽完成让NSTimer开始
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.timer setFireDate:[NSDate date]];
}
*/


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
