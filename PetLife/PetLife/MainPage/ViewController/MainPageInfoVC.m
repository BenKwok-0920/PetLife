//
//  MainPageInfoVC.m
//  PetLife
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "MainPageInfoVC.h"

@interface MainPageInfoVC ()<UIScrollViewDelegate,UIWebViewDelegate>

@property (nonatomic,strong)UIImageView *backImg;

@end

@implementation MainPageInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.backImg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _backImg.image = [UIImage imageNamed:@"loading.gif"];
    [self.view addSubview:_backImg];
    
    NSString *urlStr = [MAININFO_URL stringByAppendingString:self.mainID];
    
    
    [NetRequestManager requestWithType:GET URLString:urlStr parDic:nil finish:^(NSData *data) {
        
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        
        NSDictionary *resuDic = [dic objectForKey:@"result"];
        
        NSString *htmlStr = [resuDic objectForKey:@"content"];
        
        NSString *titleStr = [resuDic objectForKey:@"title"];
        NSLog(@"title = %@",titleStr);
        
        
        
        NSString *newHtmlStr = [htmlStr stringByAppendingString:[NSString stringWithFormat:@"<head><style>img{width:%fpx !important;}</style></head>",ScreenWidth - 15]];
        
        
        // 创建webView
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, ScreenWidth, ScreenHeight - NavigationBarHeight - 48)];
            
            webView.backgroundColor = [UIColor clearColor];
            
            webView.scalesPageToFit = NO;
            
            webView.delegate = self;
            
            
            // 去掉webView反弹效果
            [(UIScrollView *)[[webView subviews] objectAtIndex:0] setBounces:NO];
            
            UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, -100, self.view.frame.size.width, 100)];
            titleView.backgroundColor = [UIColor whiteColor];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width - 30, 100)];
            titleLabel.backgroundColor = [UIColor whiteColor];
            titleLabel.text = titleStr;
            titleLabel.textColor = [UIColor grayColor];
//          titleLabel.textAlignment = NSTextAlignmentNatural;
            titleLabel.numberOfLines = 0;
            titleLabel.font = [UIFont systemFontOfSize:20];
            
            [titleView addSubview:titleLabel];
            
            [webView.scrollView addSubview:titleView];
            
            webView.scrollView.contentOffset = CGPointMake(0, -100);
            
            webView.scrollView.showsHorizontalScrollIndicator = NO;
            
            webView.scrollView.delegate = self;
            
            webView.scrollView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
            webView.scrollView.backgroundColor = [UIColor clearColor];
            
            
            webView.scalesPageToFit = NO;
            
            [self.view addSubview:webView];
            
            NSURL *baseURL = [NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath];
            
            [webView loadHTMLString:newHtmlStr baseURL:baseURL];
            
            
        });
        
    } error:^(NSError *error) {
        NSLog(@"数据请求失败了 error = %@",error);
    }];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.x > 0) {
        scrollView.contentOffset = CGPointMake(0, point.y);//这里不要设置为CGPointMake(0, point.y)，这样我们在文章下面左右滑动的时候，就跳到文章的起始位置，不科学
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [_backImg removeFromSuperview];
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
