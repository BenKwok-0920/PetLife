//
//  FirstViewController.m
//  PetLife
//
//  Created by lanou3g on 16/4/14.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "MainPageViewController.h"
#import "NavTitleView.h"
#import "MainModel.h"
#import "MainPageTVCell.h"
#define reuseID @"cell"
#import <UIImageView+WebCache.h>
#import "MainPageInfoVC.h"
#import <MJRefreshNormalHeader.h>
#import <MJRefreshAutoFooter.h>
#import <MJRefreshAutoNormalFooter.h>

@interface MainPageViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)NavTitleView *navTitleView;

@property (nonatomic,strong)NSMutableArray *cellArray1;
@property (nonatomic,strong)NSMutableArray *cellArray2;


@property (nonatomic,strong)UIScrollView *mainScroll;

@property (nonatomic,assign)CGFloat cellHeight;

@property (nonatomic,assign)int markNum;

@property (nonatomic,strong)UITableView *tableView1;

@property (nonatomic,strong)UITableView *tableView2;

@property (nonatomic,strong)UIView *selectView;

@end

@implementation MainPageViewController


- (NSMutableArray *)cellArray1{
    if (!_cellArray1) {
        _cellArray1 = [NSMutableArray array];
    }
    return _cellArray1;
}

- (NSMutableArray *)cellArray2{
    if (!_cellArray2) {
        _cellArray2 = [NSMutableArray array];
    }
    return _cellArray2;
}


- (void)viewDidLoad {

    [super viewDidLoad];
    
    //防止scrollView乱动
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96 green:0.82 blue:0.83 alpha:1.00];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.markNum = 1;
    
    self.navTitleView = [[[NSBundle mainBundle] loadNibNamed:@"NavTitleView" owner:nil options:nil] lastObject];
    self.navTitleView.frame = CGRectMake(0, 0, ScreenWidth - 150, 44);
    
    self.navTitleView.titleBtn1.backgroundColor = [UIColor clearColor];
    self.navTitleView.titleBtn2.backgroundColor = [UIColor clearColor];
    [self.navTitleView.titleBtn1 addTarget:self action:@selector(btn1Click) forControlEvents:(UIControlEventTouchUpInside)];
    [self.navTitleView.titleBtn2 addTarget:self action:@selector(btn2Click) forControlEvents:(UIControlEventTouchUpInside)];
    
    // !!!:在此处设置头标题的按钮图片
    
    self.selectView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.navTitleView.titleBtn1.frame), 8, 75, 28)];
    self.selectView.backgroundColor = [UIColor colorWithRed:0.92 green:0.44 blue:0.55 alpha:1.00];
    self.selectView.layer.cornerRadius = 14;
    [self.navTitleView insertSubview:self.selectView belowSubview:self.navTitleView.titleBtn1];
    
    
    self.navTitleView.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.titleView = self.navTitleView;
    
    
    // 创建scrollView
    self.mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, ScreenWidth, ScreenHeight - NavigationBarHeight - 28)];
    self.mainScroll.contentSize = CGSizeMake(ScreenWidth * 2, 0);
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.bounces = NO;
    self.mainScroll.showsHorizontalScrollIndicator = NO;
    self.mainScroll.delegate = self;
    self.mainScroll.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainScroll];
    
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 48 - 64) style:(UITableViewStylePlain)];
    self.tableView1.delegate = self;
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView1.dataSource = self;
    self.tableView1.backgroundColor = [UIColor clearColor];
    self.tableView1.hidden = YES;
    [self.tableView1 registerClass:[MainPageTVCell class] forCellReuseIdentifier:reuseID];
    [self.mainScroll addSubview:self.tableView1];
    
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - 48 - 64) style:(UITableViewStylePlain)];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.hidden = YES;
    self.tableView2.backgroundColor = [UIColor clearColor];
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView2 registerClass:[MainPageTVCell class] forCellReuseIdentifier:reuseID];
    [self.mainScroll addSubview:self.tableView2];
    
    // 下拉刷新
    self.tableView1.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestDataWithURL:MAINPAGE_URL1];
        [self.tableView1.header endRefreshing];
    }];
    
    self.tableView2.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestDataWithURL:MAINPAGE_URL2];
        [self.tableView2.header endRefreshing];
    }];
    
    __block int i = 2;
    
    //上拉加载
    self.tableView1.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestDataWithURL:[NSString stringWithFormat:@"http://wecarepet.com/api/blog/blog/listCategory?category=2&filter=&page=%d",i]];
        i++;
    }];
    
    
    [self requestDataWithURL:MAINPAGE_URL1];
    
}



- (void)requestDataWithURL:(NSString *)url{
    [NetRequestManager requestWithType:GET URLString:url parDic:nil finish:^(NSData *data) {
        
        NSError *dicError = nil;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:&dicError];
        
        NSString *smallStr = [url substringFromIndex:url.length - 6];
        NSLog(@"%@",smallStr);
        
        if (self.markNum == 1) {
            
            if (self.cellArray1.count > 0 && [smallStr isEqualToString:@"page=1"]) {
                [self.cellArray1 removeAllObjects];
            }
        }else{
            if (self.cellArray2.count > 0 && [smallStr isEqualToString:@"page=1"]) {
                [self.cellArray2 removeAllObjects];
            }
        }
        
        if (!dicError) {
            
            NSArray *array = [dic objectForKey:@"result"];
            
            for (NSDictionary *resultDic in array) {
                MainModel *model = [[MainModel alloc] init];
                [model setValuesForKeysWithDictionary:resultDic];
                if (self.markNum == 1) {
                    [self.cellArray1 addObject:model];
                }else if(self.markNum == 2){
                    [self.cellArray2 addObject:model];
                }
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.markNum == 1) {
                    self.tableView1.hidden = NO;
                    [self.tableView1 reloadData];
            }else{
                    self.tableView2.hidden = NO;
                    [self.tableView2 reloadData];
            }
            });
            
            
        }else{
            NSLog(@"数据解析失败了");
        }
        
    } error:^(NSError *error) {
        NSLog(@"数据请求失败");
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 15+160+8+17+8+self.cellHeight+15;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.markNum == 1) {
        NSLog(@"arr1 = %ld",self.cellArray1.count);
        return self.cellArray1.count;
    }else{
        NSLog(@"arr2 = %ld",self.cellArray2.count);
        return self.cellArray2.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainPageTVCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    MainModel *model = nil;
    
    if (self.markNum == 1) {
        
        model = [self.cellArray1 objectAtIndex:indexPath.row];
    }else{
        model = [self.cellArray2 objectAtIndex:indexPath.row];
        
    }
    [cell.titleImg sd_setImageWithURL:[NSURL URLWithString:model.titleImg] placeholderImage:nil];
    cell.titleLabel.text = model.title;
    
    NSString *contentStr = [model.summary stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    NSString *conStr = [contentStr stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    cell.contentLabel.text = conStr;
    CGSize size = [cell.contentLabel.text sizeWithFont:cell.contentLabel.font constrainedToSize:CGSizeMake(ScreenWidth - 60, 100000) lineBreakMode:(NSLineBreakByWordWrapping)];
    cell.contentLabel.frame = CGRectMake(30, CGRectGetMaxY(cell.titleLabel.frame) + 8, ScreenWidth - 60, size.height);
    [cell.contentView addSubview:cell.contentLabel];
    
    self.cellHeight = cell.contentLabel.frame.size.height;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MainPageInfoVC *infoVC = [[MainPageInfoVC alloc] init];
    MainModel *model = nil;
    if (self.markNum == 1) {
        model = [self.cellArray1 objectAtIndex:indexPath.row];
    }else{
        model = [self.cellArray2 objectAtIndex:indexPath.row];
    }
    infoVC.mainID = model.mainID;
    
    // push
    [self.navigationController pushViewController:infoVC animated:YES];
    
}


#pragma mark - scrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float temp = self.mainScroll.contentOffset.x / ScreenWidth;
    NSLog(@"%f",temp);
//    float ttp = CGRectGetMinX(self.selectView.frame) / (CGRectGetMinX(self.navTitleView.titleBtn2.frame) - CGRectGetMinX(self.navTitleView.titleBtn1.frame));
//    ttp = temp;
    CGPoint point = self.selectView.frame.origin;
    point.x = temp * (CGRectGetMinX(self.navTitleView.titleBtn2.frame) - CGRectGetMinX(self.navTitleView.titleBtn1.frame));
//    NSLog(@"%f",point.x);
    self.selectView.frame = CGRectMake(point.x, 8, 75, 28);
    
    if (temp == 0) {
        self.markNum = 1;
        if (self.cellArray1.count != 0) {
            return;
        }
        [self requestDataWithURL:MAINPAGE_URL1];
    }else if(temp == 1){
        self.markNum = 2;
        if (self.cellArray2.count != 0) {
            return;
        }
        [self requestDataWithURL:MAINPAGE_URL2];
    }
}

#pragma mark - navigation按钮的方法
- (void)btn1Click{
    NSLog(@"按了1");
    self.markNum = 1;
    if (self.mainScroll.contentOffset.x != 0) {
        [self.mainScroll setContentOffset:CGPointMake(0, 0) animated:YES];
//        [UIView animateWithDuration:0.2 animations:^{
//            self.selectView.frame = CGRectMake(CGRectGetMinX(self.navTitleView.titleBtn1.frame), 0, 75, 44);
//        }];
        
    }
    
    if (self.cellArray1.count != 0) {
        return;
    }
    [self requestDataWithURL:MAINPAGE_URL1];
    
}

- (void)btn2Click{
    NSLog(@"按了2");
    self.markNum = 2;
    if (self.mainScroll.contentOffset.x != ScreenWidth) {
        [self.mainScroll setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
//        [UIView animateWithDuration:0.2 animations:^{
//            self.selectView.frame = CGRectMake(CGRectGetMinX(self.navTitleView.titleBtn2.frame), 0, 75, 44);
//        }];
        
    }
    
    
    if (self.cellArray2.count != 0) {
        return;
    }
    [self requestDataWithURL:MAINPAGE_URL2];
    
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
