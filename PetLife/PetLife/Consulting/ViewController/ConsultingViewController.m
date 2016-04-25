//
//  SecondViewController.m
//  PetLife
//
//  Created by lanou3g on 16/4/14.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "ConsultingViewController.h"
#import <MJRefreshNormalHeader.h>


@interface ConsultingViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webview;

@property (nonatomic,strong)NSURLRequest *request;

@property (nonatomic,strong)UIActivityIndicatorView *activity;

@end

@implementation ConsultingViewController

- (void)viewWillAppear:(BOOL)animated{
    [_webview loadRequest:_request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:1.00 green:0.51 blue:0.51 alpha:1.00];
    
//    self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
//    _activity.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
//    [_activity startAnimating];
//    [self.view addSubview:_activity];

    
    NSURL *url = [NSURL URLWithString:CONSULT_URL];
    
    self.webview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    _webview.backgroundColor = [UIColor colorWithRed:1.00 green:0.51 blue:0.51 alpha:1.00];
    
    self.request = [NSURLRequest requestWithURL:url];
    
    [_webview loadRequest:_request];
    
    _webview.delegate = self;
    
    _webview.scrollView.bounces = NO;
    
    [self.view addSubview:_webview];
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:1.00 green:0.51 blue:0.51 alpha:1.00];
    
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    statusView.backgroundColor = [UIColor colorWithRed:1.00 green:0.51 blue:0.51 alpha:1.00];
//    [self.activity removeFromSuperview];
    [self.view addSubview:statusView];
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
