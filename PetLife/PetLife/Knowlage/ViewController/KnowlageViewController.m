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

#import "LORefresh.h"


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

@property (nonatomic,strong)UIView *view11;

@property (nonatomic,assign)NSInteger firstRequestSize;
@property (nonatomic,assign)NSInteger secondRequestSize;
@property (nonatomic,assign)NSInteger thirdRequestSize;

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
    
    // 设置title字体颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[[UIFont fontWithName:@"Helvetica-Bold" size:18],[UIColor whiteColor]] forKeys:@[UITextAttributeFont,UITextAttributeTextColor]];
    
    self.navigationController.navigationBar.titleTextAttributes = dic;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.00 green:0.51 blue:0.51 alpha:1.00];
    
    mark = 0;
    _firstRequestSize = 15;
    _secondRequestSize = 15;
    _thirdRequestSize = 15;
    
    _session = [AFHTTPSessionManager manager];
    _session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    //设置是否开启状态栏动画
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadTitleNavigation];
    
     [self requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=119781&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:self.firstArray];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=120032&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:self.secondArray];
//        
//        [self requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=129147&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:self.thirdArray];
//    });
    
   
}

#pragma mark --- requestData ----

-(void)requestDataWithMark:(NSString *)url withArray:(NSMutableArray *)array{
    self.view11 = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.view11.backgroundColor = [UIColor blackColor];
    self.view11.alpha = 0.6;
//    [self.view addSubview:self.view11];
    
    [_session GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:(NSJSONReadingAllowFragments) error:nil];
        
//        [array removeAllObjects];
        
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
        
        [self.view11 removeFromSuperview];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if (!_mainScrollView) {
                [self createMainScrollView];
            }
            KnowlageHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"KnowlageHeader" owner:nil options:nil] lastObject];
            header.frame = CGRectMake(0,64, ScreenWidth, (433.0 / 650.0) * ScreenWidth);
            if (array.count > 0) {
                [header setDataWithModel:array[0]];
            }
            
            if (mark == 0) {
                
                    self.firstTableView.tableHeaderView = header;
                
                [self.firstTableView reloadData];
//                [self.firstTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
                
            }else if (mark == 1){
                self.secondTableView.tableHeaderView = header;
                
                [self.secondTableView reloadData];
            }else{
                self.thirdTableView.tableHeaderView = header;
                [self.thirdTableView reloadData];
            }
            
        });
        
//        NSLog(@"----- %@",responseObject);
//        
//        NSLog(@"firstArray%@",self.firstArray);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.view11 removeFromSuperview];
        NSLog(@"失败");
    }];
    
    _indView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    _indView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    //添加方法用于直接绑定任务
    [_indView setAnimatingWithStateOfTask:_session.tasks[0]];
    _indView.center = _indView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
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
            ssself.firstTableView.scrollsToTop = YES;
            [ssself.firstTableView reloadData];
//            [ssself.firstTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
            if (ssself.firstArray.count <= 0) {
                [ssself requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=119781&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:ssself.firstArray];
            }
            
        }else if (index == 1){
            mark = 1;
            ssself.secondTableView.scrollsToTop = YES;
            [ssself.titleNavigation changeTextColorWith:1];
            [ssself.secondTableView reloadData];
            if (ssself.secondArray.count <= 0) {
                [ssself requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=120032&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:ssself.secondArray];
            }
        }
        else{
            mark = 2;
            ssself.thirdTableView.scrollsToTop = YES;
            [ssself.titleNavigation changeTextColorWith:2];
            [ssself.thirdTableView reloadData];
//            ssself.thirdTableView.clearsContextBeforeDrawing = YES;
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
    
    
    //上拉刷新  下拉加载
    
    __weak KnowlageViewController *ssself = self;
    
    [self.firstTableView addRefreshWithRefreshViewType:(LORefreshViewTypeHeaderGif) refreshingBlock:^{
        [ssself.firstTableView.gifHeader endRefreshing];
        [ssself.firstArray removeAllObjects];
        [ssself requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=119781&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:ssself.firstArray];
    }];
    [self.firstTableView.gifHeader setGifName:@"asserxx"];
    
    
    [self.secondTableView addRefreshWithRefreshViewType:(LORefreshViewTypeHeaderGif) refreshingBlock:^{
        [ssself.secondTableView.gifHeader endRefreshing];
        [ssself.secondArray removeAllObjects];
        [ssself requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=120032&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:ssself.secondArray];
    }];
    [self.secondTableView.gifHeader setGifName:@"asserxx"];
    
    
    [self.thirdTableView addRefreshWithRefreshViewType:(LORefreshViewTypeHeaderGif) refreshingBlock:^{
        [ssself.thirdTableView.gifHeader endRefreshing];
        [ssself.thirdArray removeAllObjects];
        [ssself requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=129147&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:ssself.thirdArray];
    }];
    [self.thirdTableView.gifHeader setGifName:@"asserxx"];
    
    //下拉加载
    
    [self.firstTableView addRefreshWithRefreshViewType:(LORefreshViewTypeFooterDefault) refreshingBlock:^{
//        ssself.requestSize += 15;
        [ssself.firstTableView.defaultFooter endRefreshing];
        [ssself requestDataWithMark:[NSString stringWithFormat:@"http://client-api.dingdone.com/contents?&column_id=119781&module_id=94345&from=%ld&size=%ld&site_id=15532&slide_num=5",ssself.firstRequestSize,(ssself.firstRequestSize += 15)] withArray:ssself.firstArray];
    }];
    
    
//    if (ssself.secondArray.count <= ssself.secondRequestSize) {
    [self.secondTableView addRefreshWithRefreshViewType:(LORefreshViewTypeFooterDefault) refreshingBlock:^{
        //        ssself.requestSize += 15;
        [ssself.secondTableView.defaultFooter endRefreshing];
        [ssself requestDataWithMark:[NSString stringWithFormat:@"http://client-api.dingdone.com/contents?&column_id=120032&module_id=94345&from=%ld&size=%ld&site_id=15532&slide_num=5",ssself.secondRequestSize,(ssself.secondRequestSize += 15)] withArray:ssself.secondArray];
    }];
//      }
    
    [self.thirdTableView addRefreshWithRefreshViewType:(LORefreshViewTypeFooterDefault) refreshingBlock:^{
        //        ssself.requestSize += 15;
        [ssself.thirdTableView.defaultFooter endRefreshing];
        [ssself requestDataWithMark:[NSString stringWithFormat:@"http://client-api.dingdone.com/contents?&column_id=129147&module_id=94345&from=%ld&size=%ld&site_id=15532&slide_num=5",ssself.thirdRequestSize,(ssself.thirdRequestSize += 15)] withArray:ssself.thirdArray];
    }];
    
    
}

#pragma mark ---- scrollView  ----

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
//    
//    NSLog(@"222");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

//    NSLog(@"111");
    
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
//    NSLog(@"333");
    
    if (scrollView == self.mainScrollView) {
        
        int tap = (int)(scrollView.contentOffset.x / ScreenWidth);
        if (tap == 0) {
            mark = 0;
            [_titleNavigation changeTextColorWith:0];
            if (self.firstArray.count != 0) {
                return;
            }
            
            [self requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=119781&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:self.firstArray];
            
        }else if (tap == 1){
            mark = 1;
            [_titleNavigation changeTextColorWith:1];
            [self.secondTableView reloadData];
            if (self.secondArray.count != 0) {
                return;
            }
            
            [self requestDataWithMark:@"http://client-api.dingdone.com/contents?&column_id=120032&module_id=94345&from=0&size=15&site_id=15532&slide_num=5" withArray:self.secondArray];
        }
        else{
            mark = 2;
            [_titleNavigation changeTextColorWith:2];
            if (self.thirdArray.count != 0) {
                return;
            }
            [self.thirdTableView reloadData];
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
        if (self.firstArray.count > 0) {
            model = self.firstArray[indexPath.row];
        }
    }else if(mark == 1){
        if (self.secondArray.count > 0) {
            model = self.secondArray[indexPath.row];
        }
        
    }else{
        if (self.thirdArray.count > 0) {
            model = self.thirdArray[indexPath.row];
        }
        
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
        if (self.firstArray.count > 0) {
            model = self.firstArray[indexPath.row];
            knowlageInfoVC.number = model.number;
        }
        
    }else if(mark == 1){
        if (self.secondArray.count > 0) {
            model = self.secondArray[indexPath.row];
            knowlageInfoVC.number = model.number;
        }
    }else{
        
        if (self.thirdArray.count > 0) {
            model = self.thirdArray[indexPath.row];
            knowlageInfoVC.number = model.number;
        }
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
