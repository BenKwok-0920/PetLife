//
//  StartViewController.m
//  PetLife
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "StartViewController.h"
#import "HomePageViewController.h"

@interface StartViewController ()

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong)NSTimer *timer;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
    _imageView.backgroundColor = [UIColor colorWithRed:1.000 green:0.800 blue:0.800 alpha:1.000];
    _imageView.image = [UIImage imageNamed:@"start_mengchong_2"];
    [self.view addSubview:_imageView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
   
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [UIView setAnimationDelegate:self];
    
    _imageView.alpha = 0.9;
    _imageView.frame = CGRectMake(-50, -200, self.view.frame.size.width +150, self.view.frame.size.height + 200);
    [UIView commitAnimations];
    
   self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(startAction) userInfo:nil repeats:YES];
    
    
}

- (void)startAction {
    NSLog(@"ogogog-----");
    
    //干掉定时器
    [self.timer invalidate];
    
    HomePageViewController *homePage = [[HomePageViewController alloc]init];
    //tia
    homePage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UINavigationController *anotherNC = [[UINavigationController alloc] initWithRootViewController:homePage];
    
    [self.navigationController presentViewController:anotherNC animated:YES completion:nil];
    
    
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
