//
//  FourthViewController.m
//  PetLife
//
//  Created by lanou3g on 16/4/14.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "MySelfViewController.h"
#import "MySelfTableViewCell.h"
#import "FeedBackViewController.h"
#import "StatementViewController.h"
#import "AboutViewController.h"
#import "SDImageCache.h"


#define KVwidth self.view.frame.size.width
#define KVheight self.view.frame.size.height


@interface MySelfViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>



@property (nonatomic,strong)UITableView *tableMySelf;
@property (nonatomic,strong)UIImageView *backImage;
//@property (nonatomic,strong)UIView *titleView;
@property (nonatomic,strong)UIImageView *imageTitle;

@property (nonatomic,strong)NSString *stringHC;


@end

@implementation MySelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.00 green:0.51 blue:0.51 alpha:1.00];
    
    // 设置title字体颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[[UIFont fontWithName:@"Helvetica-Bold" size:18],[UIColor whiteColor]] forKeys:@[UITextAttributeFont,UITextAttributeTextColor]];
    
    self.navigationController.navigationBar.titleTextAttributes = dic;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.tableMySelf = [[UITableView alloc]initWithFrame:CGRectMake(0, 260, KVwidth, KVheight - 304 ) style:(UITableViewStylePlain)];
    self.tableMySelf.scrollEnabled = NO;
    self.tableMySelf.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //view
//    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KVwidth, 260)];
//    self.titleView.backgroundColor = [UIColor colorWithRed:0.96 green:0.82 blue:0.83 alpha:1.00];
    self.backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.backImage.image = [UIImage imageNamed:@"pinkcolor_background"];
    
    
    
    //头像
    self.imageTitle = [[UIImageView alloc]initWithFrame:CGRectMake((KVwidth - 120)/2,120 ,120, 120)];
    self.imageTitle.image = [UIImage imageNamed:@"petLife-1024"];
    self.imageTitle.layer.masksToBounds=YES;
    self.imageTitle.layer.cornerRadius = 10;
    
    //注册
    [self.tableMySelf registerClass:[MySelfTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableMySelf.delegate = self;
    self.tableMySelf.dataSource = self;
    
    //添加
    [self.view addSubview:_backImage];
    [self.backImage addSubview:self.imageTitle];
    [self.view addSubview:self.tableMySelf];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MySelfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.textLabel.text = @"1234";
    switch (indexPath.row) {
        case 0:
           cell.labelBar.text = @"清除缓存";
            cell.imagBar.image = [UIImage imageNamed:@"huancun-16@1x"];
            [self getCacheSize];
            cell.huancun.text = self.stringHC;
            break;
        case 1:
            cell.labelBar.text = @"意见反馈";
            cell.imagBar.image = [UIImage imageNamed:@"yijian-16"];
            break;
        case 2:
            cell.labelBar.text = @"免责声明";
            cell.imagBar.image = [UIImage imageNamed:@"mianze-16@1x"];
            break;
        case 3:
            cell.labelBar.text = @"关于我们";
            cell.imagBar.image = [UIImage imageNamed:@"guanyu-16@1x"];
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            [self dianji];
            break;
        case 1:
        [self.navigationController pushViewController:[[FeedBackViewController alloc]init] animated:YES];
            break;
        case 2:
            
         [self.navigationController pushViewController:[[StatementViewController alloc] init] animated:YES];
         
            break;
        case 3:
            [self.navigationController pushViewController:[[AboutViewController alloc]init] animated:YES];
            break;
        default:
            break;
    }

}



#pragma mark ------清除缓存
- (void)dianji{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"缓存清除" message:@"确定清除缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alertView show];
}

 #pragma mark - 计算缓存大小
- (NSString *)getCacheSize{
    //定义变量存储总的缓存大小
    long long sumSize = 0;
    //01.获取当前图片缓存路径
    NSString *cacheFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];

    //02.创建文件管理对象
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:cacheFilePath]) {
        long long huancun = [[filemanager attributesOfItemAtPath:cacheFilePath error:nil] fileSize];
        self.stringHC = [NSString stringWithFormat:@"%2lldM",huancun - 102];
        NSLog(@"caches == % vXZ@",self.stringHC);
        return self.stringHC;
    }else{
        return 0;
    }
    
    
}
#pragma mark - UIAlertViewDelegate方法实现
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //判断点击的是确认键
    if (buttonIndex == 1) {
    //01......
        NSFileManager *fileManager = [NSFileManager defaultManager];
    //02.....
        NSString *cacheFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //03......
//        [fileManager removeItemAtPath:cacheFilePath error:nil];
        
        if ([fileManager fileExistsAtPath:cacheFilePath]) {
            NSArray *childerFiles = [fileManager subpathsAtPath:cacheFilePath];
            for (NSString *fileName in childerFiles) {
                NSString *absolutePath = [cacheFilePath stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:nil];
            }
        }
        [[SDImageCache sharedImageCache] cleanDisk];
    
    //04刷新第一行单元格
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [_tableMySelf reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    //05 ：04和05使用其一即可
        [_tableMySelf reloadData];//刷新表视图
    }
}

//@pragma -mark -放置于.m文件首段较为合适，本DEMO仅做功能性展示，实时监测缓存大小，从其他界面跳转到本页面，也需要刷新下表视图
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_tableMySelf reloadData];
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
