//
//  ViewController.m
//  DanLi
//
//  Created by Qu ZhongLiang on 17/6/9.
//  Copyright © 2017年 Qu ZhongLiang. All rights reserved.
//

#import "ViewController.h"
#import "MMAlertView.h"
@interface ViewController ()
@property(nonatomic, strong)MMAlertView *aview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 50);
    button.backgroundColor = [UIColor purpleColor];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    }

- (void)buttonClick{
    [self creatView];
}
- (void)creatView
{
    if (_aview) {
        [_aview removeFromSuperview];
    }
    _aview =[[MMAlertView alloc ]initWithTitle:@"温习提示" detailTitle:@"您可领取50积分" image:[UIImage imageNamed:@"timg.jpg"] btnTitle:@"领取"  detailHeight:50];
    [self.view addSubview:_aview];
    [_aview nextActionEv:^{
        NSLog(@"点击了按钮");
    }];
 
}
@end
