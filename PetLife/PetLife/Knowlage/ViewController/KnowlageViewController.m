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

#import "KnowlageModel.h"
#import "KnowlageTableViewCell.h"
#import "KnowlageHeader.h"

#import "KnowlageInfoViewController.h"


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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.600 alpha:1.000];
    
    mark = 0;
    
    _session = [AFHTTPSessionManager manager];
    _session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    //设置是否开启状态栏动画
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
     [self requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=119781&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:self.firstArray];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadTitleNavigation];
    
    
   
}

#pragma mark --- requestData ----

-(void)requestDataWithMark:(NSString *)url withArray:(NSMutableArray *)array{
    
    [_session GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:(NSJSONReadingAllowFragments) error:nil];
        NSDictionary *dic = responseObject;
        NSArray *arr = [dic objectForKey:@"data"];
        for (NSDictionary *dictionary in arr) {
            
            KnowlageModel *model = [[KnowlageModel alloc] init];
            [model setValuesForKeysWithDictionary:dictionary];
            NSString *str1 = dictionary[@"indexPic"][@"host"];
            NSString *dir = dictionary[@"indexPic"][@"dir"];
            NSString *filepath = dictionary[@"indexPic"][@"filepath"];
            NSString *filename = dictionary[@"indexPic"][@"filename"];
//            NSLog(@"str1 %@",str1);
//            NSLog(@"str1 %@",str1);
            model.img = [[[str1 stringByAppendingString:dir] stringByAppendingString:filepath] stringByAppendingString:filename];
            
            [array addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if (!_mainScrollView) {
                [self createMainScrollView];
            }
            KnowlageHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"KnowlageHeader" owner:nil options:nil] lastObject];
            header.frame = CGRectMake(0,64, ScreenWidth, (433.0 / 650.0) * ScreenWidth);
            [header setDataWithModel:array[0]];
            if (mark == 0) {

                self.firstTableView.tableHeaderView = header;
                
                [self.firstTableView reloadData];
            }else if (mark == 1){
                
                self.secondTableView.tableHeaderView = header;
                
                [self.secondTableView reloadData];
            }else{
                self.thirdTableView.tableHeaderView = header;
                [self.thirdTableView reloadData];
            }
            
        });
        
        NSLog(@"----- %@",responseObject);
        
        NSLog(@"firstArray%@",self.firstArray);
        
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
    
    __weak KnowlageViewController *ssself = self;
    _titleNavigation.btnAction = ^(int index){
    
        ssself.mainScrollView.contentOffset = CGPointMake(ScreenWidth * index, 0);
        
        
        if (index == 0) {
            mark = 0;
            [ssself.titleNavigation changeTextColorWith:0];
            if (ssself.firstArray.count <= 0) {
                [ssself requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=119781&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:ssself.firstArray];
            }
            
        }else if (index == 1){
            mark = 1;
            [ssself.titleNavigation changeTextColorWith:1];
            if (self.firstArray.count <= 0) {
                //        [self requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=119781&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:self.firstArray];
            }
        }
        else{
            mark = 2;
            [ssself.titleNavigation changeTextColorWith:2];
            if (ssself.thirdArray.count <= 0) {
                [ssself requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=129147&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:ssself.thirdArray];
            }
            
        }

        
        
        
    };
    [_titleNavigation changeTextColorWith:0];
    [tempView addSubview:_titleNavigation];
    [self.view addSubview:tempView];
    
}

-(void)createMainScrollView{
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight - 104 - 49)];
    self.mainScrollView.backgroundColor = [UIColor redColor];
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth * 3, ScreenHeight - 104 - 49);
    self.mainScrollView.delegate = self;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.bounces = NO;
    [self.view addSubview:self.mainScrollView];
    
    [self createTableView];
}


-(void)createTableView{
    
    self.firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 104 - 49) style:(UITableViewStylePlain)];
    self.firstTableView.delegate = self;
    self.firstTableView.dataSource = self;
//    [self.firstTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.firstTableView registerNib:[UINib nibWithNibName:@"KnowlageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.mainScrollView addSubview:self.firstTableView];
    
    
    self.secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - 104 - 49) style:(UITableViewStylePlain)];
    self.secondTableView.delegate = self;
    self.secondTableView.dataSource = self;
//    [self.secondTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
     [self.secondTableView registerNib:[UINib nibWithNibName:@"KnowlageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.mainScrollView addSubview:self.secondTableView];
    
    
    self.thirdTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth * 2, 0, ScreenWidth, ScreenHeight - 104 - 49) style:(UITableViewStylePlain)];
    self.thirdTableView.delegate = self;
    self.thirdTableView.dataSource = self;
//    [self.thirdTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
     [self.thirdTableView registerNib:[UINib nibWithNibName:@"KnowlageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.mainScrollView addSubview:self.thirdTableView];
    
}

#pragma mark ---- scrollView  ----

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

  
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int tap = (int)(scrollView.contentOffset.x / ScreenWidth);
    if (tap == 0) {
        mark = 0;
        [_titleNavigation changeTextColorWith:0];
        if (self.firstArray.count <= 0) {
            [self requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=119781&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:self.firstArray];
        }
        
    }else if (tap == 1){
        mark = 1;
        [_titleNavigation changeTextColorWith:1];
        if (self.firstArray.count <= 0) {
//        [self requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=119781&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:self.firstArray];
        }
    }
    else{
        mark = 2;
        [_titleNavigation changeTextColorWith:2];
        if (self.thirdArray.count <= 0) {
            [self requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=129147&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:self.thirdArray];
        }
        
    }
    
}




#pragma mark --- tableViewdelegate  -----

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (mark == 0) {
        return self.firstArray.count;
    }else if(mark == 1){
    
        return self.secondArray.count;
    }else{
        return self.thirdArray.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    KnowlageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    KnowlageModel *model;
    if (mark == 0) {
        model = self.firstArray[indexPath.row];
    }else if(mark == 1){
        model = self.secondArray[indexPath.row];
    }else{
        model = self.thirdArray[indexPath.row];
    }
    
    
    
    [cell setDataWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    KnowlageInfoViewController *knowlageInfoVC = [[KnowlageInfoViewController alloc] init];
    KnowlageModel *model;
    if (mark == 0) {
        model = self.firstArray[indexPath.row];
        knowlageInfoVC.number = model.number;
    }else if(mark == 1){
        model = self.secondArray[indexPath.row];
        knowlageInfoVC.number = model.number;
    }else{
        model = self.thirdArray[indexPath.row];
        knowlageInfoVC.number = model.number;
    }
    
    [self.navigationController pushViewController:knowlageInfoVC animated:YES];
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
