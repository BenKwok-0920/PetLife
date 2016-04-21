//
//  MainPageInfoVC.m
//  PetLife
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "MainPageInfoVC.h"
#import "NSString+Html.h"

@interface MainPageInfoVC ()

@end

@implementation MainPageInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *urlStr = [MAININFO_URL stringByAppendingString:self.mainID];
    
    
    [NetRequestManager requestWithType:GET URLString:urlStr parDic:nil finish:^(NSData *data) {
        
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        
        NSDictionary *resuDic = [dic objectForKey:@"result"];
        
        NSString *htmlStr = [resuDic objectForKey:@"content"];
        
        NSString *titleStr = [resuDic objectForKey:@"title"];
        NSLog(@"title = %@",titleStr);
        
//        NSString *str = [NSString importStyleWithHtmlString:htmlStr];
        
        NSString *newHtmlStr = [htmlStr stringByAppendingString:[NSString stringWithFormat:@"<head><style>img{width:%fpx !important;}</style></head>",ScreenWidth - 15]];
        
        // 创建webView
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, ScreenWidth, ScreenHeight - NavigationBarHeight - 48)];
            
            webView.scalesPageToFit = NO;
            
            UIScrollView *scroller = [webView.subviews objectAtIndex:0];
            if (scroller){
                scroller.bounces = NO;
                scroller.alwaysBounceVertical = NO;
                scroller.alwaysBounceHorizontal = NO;
            }
            
            // 去掉webView反弹效果
            [(UIScrollView *)[[webView subviews] objectAtIndex:0] setBounces:NO];
            
            UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, -100, self.view.frame.size.width, 100)];
            titleView.backgroundColor = [UIColor whiteColor];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width - 30, 100)];
            titleLabel.backgroundColor = [UIColor whiteColor];
            titleLabel.text = titleStr;
            titleLabel.textColor = [UIColor grayColor];
            //            titleLabel.textAlignment = NSTextAlignmentNatural;
            titleLabel.numberOfLines = 0;
            titleLabel.font = [UIFont systemFontOfSize:20];
            
            [titleView addSubview:titleLabel];
            
            [webView.scrollView addSubview:titleView];
            
            
            webView.scrollView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
            
            webView.scalesPageToFit = NO;
            
            [self.view addSubview:webView];
            
            NSURL *baseURL = [NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath];
            
            [webView loadHTMLString:newHtmlStr baseURL:baseURL];
        });
        
    } error:^(NSError *error) {
        NSLog(@"数据请求失败了 error = %@",error);
    }];
    
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
