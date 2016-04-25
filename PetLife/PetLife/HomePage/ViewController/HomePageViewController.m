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
#import "StartViewController.h"

@interface HomePageViewController ()
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)StartViewController *starVC;

@property (nonatomic,strong)UIImageView *imageView;


@end

@implementation HomePageViewController


- (void)startAction {
    
    //干掉定时器
    [self.timer invalidate];
    
    //干掉view
    [self.starVC removeFromSuperview];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.starVC = [[StartViewController alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.starVC.backgroundColor = [UIColor colorWithRed:1.000 green:0.800 blue:0.800 alpha:1.000];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
    _imageView.image = [UIImage imageNamed:@"start_mengchong_4"];
    [self.starVC addSubview:_imageView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [UIView setAnimationDelegate:self];
//    _imageView.alpha = 0.9;
    _imageView.frame = CGRectMake(-50, -200, self.view.frame.size.width +150, self.view.frame.size.height + 200);
    [UIView commitAnimations];
    [self.view addSubview:self.starVC];
    //定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(startAction) userInfo:nil repeats:YES];
    
    
    //首页
    MainPageViewController *mainPageVC = [[MainPageViewController alloc]init];
    UINavigationController *SYnav = [[UINavigationController alloc]initWithRootViewController:mainPageVC];
    mainPageVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"home.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] selectedImage:[[UIImage imageNamed:@"home_H.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    
    
    //咨询
    ConsultingViewController *consultingVC = [[ConsultingViewController alloc]init];
    UINavigationController *ZXnav= [[UINavigationController alloc]initWithRootViewController:consultingVC];
    consultingVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"助手" image:[[UIImage imageNamed:@"tiwen.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] selectedImage:[[UIImage imageNamed:@"tiwen_H.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    
    //我的
    MySelfViewController *mySelfVC = [[MySelfViewController alloc]init];
    UINavigationController *WDnav = [[UINavigationController alloc]initWithRootViewController:mySelfVC];
    mySelfVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"myself.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] selectedImage:[[UIImage imageNamed:@"myself_H.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    
    
    //知识
    KnowlageViewController *knowlageVC = [[KnowlageViewController alloc] init];
    UINavigationController *ZSnav = [[UINavigationController alloc] initWithRootViewController:knowlageVC];
    ZSnav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"知识" image:[[UIImage imageNamed:@"knowlage.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] selectedImage:[[UIImage imageNamed:@"knowlage_H.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    
    
    self.viewControllers = @[SYnav,ZSnav,ZXnav,WDnav];
    
    self.tabBar.tintColor = [UIColor colorWithRed:0.87 green:0.40 blue:0.45 alpha:1.00];
    
    [self isConnectionAvailable];
    
}

- (BOOL)isConnectionAvailable{
    
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



@end
