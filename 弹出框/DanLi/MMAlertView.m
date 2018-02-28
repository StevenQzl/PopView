//
//  MMAlertView.m
//  trext
//
//  Created by seer on 2017/4/11.
//  Copyright © 2017年 Ims. All rights reserved.
//

#import "MMAlertView.h"

//加入这个宏，可以省略所有 mas_ （除了mas_equalTo）
#define MAS_SHORTHAND

//加入这个宏，那么mas_equalTo就和equalTo一样的了
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>

@implementation MMAlertView
-(instancetype)initWithTitle:(NSString *)title detailTitle:(NSString *)detail image:(UIImage *)images btnTitle:(NSString *)btnTitle detailHeight:(CGFloat)floa{
    self =[super init];
    if (self) {
        self.images =images;
        self.title =title;
        self.detailTitle =detail;
        self.btnTitle =btnTitle;
        self.floa =floa;
        [self initUI];
    }
    return self;
}
-(void)initUI{
    CGFloat screenW =[UIScreen mainScreen].bounds.size.width;
    CGFloat screenH =[UIScreen mainScreen].bounds.size.height;
    CGFloat alertW =screenW *0.6;
    CGFloat alertH =alertW/3*4;
    
    [self setFrame:CGRectMake(0, 0, screenW, screenH)];
    [self setBackgroundColor:[UIColor clearColor]];
    
    UIView *shandow =[[UIView alloc]initWithFrame:self.frame];
    [shandow setBackgroundColor:[UIColor lightGrayColor]];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeShandow)];
    [shandow addGestureRecognizer:tap];
    [shandow setAlpha:0.7];
    [self addSubview:shandow];
    
    UIView *alert =[[UIView alloc]init];
    [alert setBackgroundColor:[UIColor whiteColor]];
    alert.layer.cornerRadius =5;
    alert.layer.masksToBounds =YES;
    [self addSubview:alert];
    [alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(alertW, alertH));
        make.center.equalTo(self.center);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self shakeToView:alert];
    
  
    UIButton *action =[[UIButton alloc]init];
    action.layer.cornerRadius =5;
    [action.titleLabel setFont:[UIFont systemFontOfSize:16]];
    action.layer.masksToBounds =YES;
    [action setBackgroundColor:MM_MAINCOLOR];
    [action setTitle:self.btnTitle forState:UIControlStateNormal];
    [action addTarget:self action:@selector(nextActionEvent) forControlEvents:UIControlEventTouchUpInside];
    [alert addSubview:action];
    [action mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(alert.mas_bottom).with.offset(-20);
        make.left.equalTo(alert.mas_left).with.offset(40);
        make.right.equalTo(alert.mas_right).with.offset(-40);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *detailLab =[[UILabel alloc]init];
    [detailLab setNumberOfLines:4];
    [detailLab setFont:[UIFont systemFontOfSize:14]];
    [detailLab setTextColor:MM_FONT999];
    [detailLab setTextAlignment:NSTextAlignmentCenter];
    [detailLab setText:self.detailTitle];
    [alert addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(action.top).with.offset(-10);
        make.left.equalTo(action.left);
        make.height.equalTo(self.floa);
        make.width.equalTo(action.width);
    }];
    
    UILabel *title =[[UILabel alloc]init];
    [title setFont:[UIFont boldSystemFontOfSize:16]];
    [title setTextColor:MM_FONT333];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setText:self.title];
    [alert addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(detailLab.top).with.offset(0);
        make.left.equalTo(detailLab.left);
        make.height.equalTo(25);
        make.width.equalTo(detailLab.width);
    }];
    
    UIImageView *imageV =[[UIImageView alloc]init];
    [imageV setImage:self.images];
    [imageV setContentMode:UIViewContentModeScaleAspectFit];
    [alert addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(alert.width);
        make.bottom.equalTo(title.top).with.offset(-14);
        make.left.equalTo(0);
        make.top.equalTo(alert.top).mas_offset(20);
    }];
}
//动画
- (void)shakeToView:(UIView *)aview
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.35;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f,0.01f,1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05f, 1.05f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95f, 0.95f, 1.0f)] ];
    [NSValue valueWithCATransform3D:CATransform3DIdentity];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @0.8f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [aview.layer addAnimation:popAnimation forKey:nil];
}

-(void)nextActionEvent{
   self.nextAction();
    [self removeFromSuperview];
}


-(void)closeShandow{
    [self removeFromSuperview];
    NSLog(@"测试代码");
}

-(void)nextActionEv:(Action)action{
    self.nextAction =action;
    NSLog(@"我是甲开发人员");
}


@end
