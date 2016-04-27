//
//  FeedBackViewController.m
//  PetLife
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *questionText;
@property (weak, nonatomic) IBOutlet UITextView *fedBackText;

@property (weak, nonatomic) IBOutlet UIView *submitButton;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"意见反馈";
    // Do any additional setup after loading the view from its nib.
    //设置键盘只能是英文状态
    self.emailText.keyboardType = UIKeyboardTypeASCIICapable;
    self.submitButton.layer.cornerRadius = 20;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.emailText resignFirstResponder];
    [self.fedBackText resignFirstResponder];
    [self.questionText resignFirstResponder];
}

- (IBAction)submitAction:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"意见反馈" message:@"感谢您的反馈！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [alertView show];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
