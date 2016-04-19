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
//#import "MyCell.h"
#import "MyTableCell.h"
#import "CellModel.h"
#import "ItemModel.h"

#import "FootView.h"

#define reuseID @"cell"

@interface MainPageViewController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *scrollArray;

@property (nonatomic,strong)NSArray *arr;

// tableView
@property (nonatomic,strong)UITableView *tableV;

@property (nonatomic,strong)SDCycleScrollView *cycleScroll;

@property (nonatomic,strong)NSMutableArray *cellArr;

@property (nonatomic,strong)NSMutableArray *itemArr;


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

- (NSArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

- (NSMutableArray *)cellArr{
    if (!_cellArr) {
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}

- (NSMutableArray *)itemArr{
    if (!_itemArr) {
        _itemArr = [NSMutableArray array];
    }
    return _itemArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"caidan_16"] style:(UIBarButtonItemStyleDone) target:self action:@selector(CDitemAction:)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

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
            self.arr = [dic objectForKey:@"data"];
            // arr 里面的第0个字典 就是scrollView的数据
            NSDictionary *scrollDic = self.arr[0];
            NSArray *scArr = [scrollDic objectForKey:@"data"];
            for (NSDictionary *scDic in scArr) {
                NSLog(@"创建model了");
                ScrollModel *model = [[ScrollModel alloc] init];
                [model setValuesForKeysWithDictionary:scDic];
                [self.scrollArray addObject:model];
                [self.imgArr addObject:model.img];
                [self.titArr addObject:model.text];
            }
            
            // arr里面的第2到第8个字典 是collecetionView的数据
            for (NSDictionary *tableDic in self.arr) {
                if ([[NSString stringWithFormat:@"%@",[tableDic objectForKey:@"is_more"]] isEqualToString:@"1"] && ((NSArray *)[tableDic objectForKey:@"data"]).count > 0) {
                    CellModel *cellModel = [[CellModel alloc] init];
                    [cellModel setValuesForKeysWithDictionary:tableDic];
                    [self.cellArr addObject:cellModel];
                    
                    // item
                    NSArray *itemArr = [tableDic objectForKey:@"data"];
                    for (NSDictionary *itemDic in itemArr) {
                        ItemModel *itemModel = [[ItemModel alloc] init];
                        [itemModel setValuesForKeysWithDictionary:itemDic];
                        [self.itemArr addObject:itemModel];
                    }
                }
            }
            
            // 创建scrollView
            dispatch_async(dispatch_get_main_queue(), ^{
//                [self createScrollView];
                [self.tableV reloadData];
                // 创建下面的模块
                [self createCollect];
            });
            
            
            
        }else{
            NSLog(@"数据解析失败,error=%@",error);
        }
        
    } error:^(NSError *error) {
        NSLog(@"首页请求数据失败!!!%@",error);
    }];
}


- (void)createScrollView{
    
    self.cycleScroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, NavigationBarHeight, ScreenWidth, ImgHeight) delegate:self placeholderImage:nil];
    self.cycleScroll.imageURLStringsGroup = self.imgArr;
    
    self.cycleScroll.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    self.cycleScroll.titlesGroup = self.titArr;
    
    self.cycleScroll.autoScrollTimeInterval = 3.5;
    
    self.cycleScroll.delegate = self;
    
    self.cycleScroll.pageControlDotSize = CGSizeMake(20, 20);
    
    
    [self.view addSubview:self.cycleScroll];
    
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

- (void)createCollect{
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, ScreenWidth, ScreenHeight - NavigationBarHeight - 48)];
    
    self.tableV.allowsSelection = NO;
    
    self.tableV.bounces = NO;
    
    [self createScrollView];
    
    self.tableV.tableHeaderView = self.cycleScroll;
    
//    FootView *footView = [[FootView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 96)];
    FootView *footView = [[[NSBundle mainBundle] loadNibNamed:@"FootView" owner:nil options:nil] lastObject];
    footView.frame = CGRectMake(0, 0, ScreenWidth, 70);
    footView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableV.tableFooterView = footView;
    
    [self.tableV registerClass:[MyTableCell class] forCellReuseIdentifier:reuseID];
    
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    
    [self.view addSubview:self.tableV];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",self.arr.count);
    return self.cellArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    CellModel *cellModel = self.cellArr[indexPath.row];
    cell.titleLabel.text = cellModel.title;
    
    
    
    ItemModel *itemModel1 = self.itemArr[indexPath.row * 4];
    [cell.myImg1.itemImg sd_setImageWithURL:[NSURL URLWithString:itemModel1.img] placeholderImage:nil];
    cell.myImg1.itemLabel.text = itemModel1.text;
    
    ItemModel *itemModel2 = self.itemArr[indexPath.row * 4 + 1];
    [cell.myImg2.itemImg sd_setImageWithURL:[NSURL URLWithString:itemModel2.img] placeholderImage:nil];
    cell.myImg2.itemLabel.text = itemModel2.text;
    
    ItemModel *itemModel3 = self.itemArr[indexPath.row * 4 + 2];
    [cell.myImg3.itemImg sd_setImageWithURL:[NSURL URLWithString:itemModel3.img] placeholderImage:nil];
    cell.myImg3.itemLabel.text = itemModel3.text;
    
    ItemModel *itemModel4 = self.itemArr[indexPath.row * 4 + 3];
    [cell.myImg4.itemImg sd_setImageWithURL:[NSURL URLWithString:itemModel4.img] placeholderImage:nil];
    cell.myImg4.itemLabel.text = itemModel4.text;
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return collectHeight - 8;
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
