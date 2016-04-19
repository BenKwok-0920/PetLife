//
//  KnowlageViewController.m
//  PetLife
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "KnowlageViewController.h"
#import "TitleNavigation.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "UIActivityIndicatorView+AFNetworking.h"


@interface KnowlageViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

{

    NSInteger mark;
}

@property (nonatomic,strong)TitleNavigation *titleNavigation;
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)UITableView *firstTableView;
@property (nonatomic,strong)NSMutableArray *firstArray;

@property (nonatomic,strong)UITableView *secondTableView;
@property (nonatomic,strong)NSMutableArray *secondArray;

@property (nonatomic,strong)UITableView *thirdTableView;
@property (nonatomic,strong)NSMutableArray *thirdArray;

@property (nonatomic,strong)AFHTTPSessionManager *session;
@property (nonatomic,strong)UIActivityIndicatorView *indView;


@end

@implementation KnowlageViewController

-(NSMutableArray *)firstArray{

    if (!_firstArray) {
        _firstArray = [NSMutableArray array];
    }
    return _firstArray;
}

-(NSMutableArray *)secondArray{

    if (!_secondArray) {
        _secondArray = [NSMutableArray array];
    }
    return _secondArray;
}

-(NSMutableArray *)thirdArray{

    if (!_thirdArray) {
        _thirdArray = [NSMutableArray array];
    }
    return _thirdArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"知识";
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    
    mark = 0;
    
    _session = [AFHTTPSessionManager manager];
    _session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    //设置是否开启状态栏动画
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadTitleNavigation];
    [self createMainScrollView];
    
    [self requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=119781&module_id=94345&from=0&size=15&site_id=15532&slide_num=5"];
}

#pragma mark --- requestData ----

-(void)requestDataWithMark:(NSString *)url{
    
    [_session GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"----- %@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
    
    _indView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    //添加方法用于直接绑定任务
    [_indView setAnimatingWithStateOfTask:_session.tasks[0]];
    _indView.center = CGPointMake(100, 150);
    [self.view addSubview:_indView];
    [_indView startAnimating];
    
}


-(void)loadTitleNavigation{
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 40)];
    
    _titleNavigation = [[[NSBundle mainBundle] loadNibNamed:@"TitleNavigation" owner:nil options:nil] lastObject];
    _titleNavigation.frame = tempView.bounds;
    [_titleNavigation changeTextColorWith:1];
    [tempView addSubview:_titleNavigation];
    [self.view addSubview:tempView];
    
}

-(void)createMainScrollView{
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight - 104 - 49)];
    self.mainScrollView.backgroundColor = [UIColor redColor];
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth * 3, ScreenHeight - 104 - 49);
    self.mainScrollView.delegate = self;
    self.mainScrollView.pagingEnabled = YES;
    [self.view addSubview:self.mainScrollView];
    
    [self createTableView];
}


-(void)createTableView{
    
    self.firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 104 - 49) style:(UITableViewStylePlain)];
    self.firstTableView.delegate = self;
    self.firstTableView.dataSource = self;
    [self.firstTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.mainScrollView addSubview:self.firstTableView];
    
    
    self.secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - 104 - 49) style:(UITableViewStylePlain)];
    self.secondTableView.delegate = self;
    self.secondTableView.dataSource = self;
    [self.secondTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.mainScrollView addSubview:self.secondTableView];
    
    
    self.thirdTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth * 2, 0, ScreenWidth, ScreenHeight - 104 - 49) style:(UITableViewStylePlain)];
    self.thirdTableView.delegate = self;
    self.thirdTableView.dataSource = self;
    [self.thirdTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.mainScrollView addSubview:self.thirdTableView];
    
}

#pragma mark ---- scrollView  ----

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    
}


#pragma mark --- tableViewdelegate  -----

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (mark == 0) {
//        cell
        cell.textLabel.text = @"你好";
    }else if(mark == 1){
    
//        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.textLabel.text = @"大家好";
    }else{
//        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.textLabel.text = @"我好";
    }
    
    return cell;
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
