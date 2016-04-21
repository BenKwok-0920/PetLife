//
//  HomePageViewController.m
//  PetLife
//
//  Created by lanou3g on 16/4/14.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "HomePageViewController.h"
#import "MainPageViewController.h"
#import "ConsultingViewController.h"
#import "MySelfViewController.h"
#import "KnowlageViewController.h"


#import "Reachability.h"
#import "MBProgressHUD.h"
@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //首页
    MainPageViewController *mainPageVC = [[MainPageViewController alloc]init];
    UINavigationController *SYnav = [[UINavigationController alloc]initWithRootViewController:mainPageVC];
    mainPageVC.tabBarItem.title = @"首页";
    mainPageVC.tabBarItem.image = [[UIImage imageNamed:@"zhuye_black_16"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //咨询
    ConsultingViewController *consultingVC = [[ConsultingViewController alloc]init];
    UINavigationController *ZXnav= [[UINavigationController alloc]initWithRootViewController:consultingVC];
    consultingVC.tabBarItem.title = @"咨询";
    consultingVC.tabBarItem.image = [[UIImage imageNamed:@"zixun_black_16"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    consultingVC.tabBarController.tabBar.tintColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.600 alpha:0.703];
    
    //我的
    MySelfViewController *mySelfVC = [[MySelfViewController alloc]init];
    UINavigationController *WDnav = [[UINavigationController alloc]initWithRootViewController:mySelfVC];
    mySelfVC.tabBarItem.title = @"我的";
    mySelfVC.tabBarItem.image = [[UIImage imageNamed:@"wode_black_16"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //知识
    KnowlageViewController *knowlageVC = [[KnowlageViewController alloc] init];
    UINavigationController *ZSnav = [[UINavigationController alloc] initWithRootViewController:knowlageVC];
    ZSnav.tabBarItem.title = @"知识";
    ZSnav.tabBarItem.image = [[UIImage imageNamed:@"zhishi_black_16"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    self.viewControllers = @[SYnav,ZSnav,ZXnav,WDnav];
    
    [self isConnectionAvailable];
    
}

-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];//<span style="font-family: Arial, Helvetica, sans-serif;">MBProgressHUD为第三方库，不需要可以省略或使用AlertView</span>
        hud.removeFromSuperViewOnHide =YES;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"网络连接失败";
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hide:YES afterDelay:3];
        return NO;
    }
    
    return isExistenceNetwork;
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
