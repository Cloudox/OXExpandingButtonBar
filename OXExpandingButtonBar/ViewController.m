//
//  ViewController.m
//  OXExpandingButtonBar
//
//  Created by Cloudox on 15/12/8.
//  Copyright (c) 2015年 Cloudox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGPoint center = CGPointMake(50.0f, 400.0f);
    CGRect buttonFrame = CGRectMake(0, 0, 35.0f, 35.0f);
    
    // 主按钮
    UIButton *mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mainBtn setFrame:buttonFrame];
    [mainBtn setBackgroundImage:[UIImage imageNamed:@"btn_quickoption_route"] forState:UIControlStateNormal];
    mainBtn.transform = CGAffineTransformMakeRotation(- M_PI*(45)/180.0);
    mainBtn.alpha = 0.5;
    
    // 子按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:buttonFrame];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"sumitmood"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1Tap) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setFrame:buttonFrame];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"submit_pressed"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Tap) forControlEvents:UIControlEventTouchUpInside];
    NSArray *buttons = [NSArray arrayWithObjects:btn1, btn2, nil];
    
    // 初始化控件
    self.bar = [[OXExpandingButtonBar alloc] initWithMainButton:mainBtn buttons:buttons center:center];
//    [self.bar setMainRotate:0.0f];// 设置展开时主按钮旋转到的角度
//    [self.bar setMainReRotate:- M_PI*(45)/180.0];// 设置收起时主按钮旋转到的角度
//    [self.bar setSpin:YES];// 设置弹出子按钮时是否旋转子按钮
//    [self.bar setEndY:30.0f];// 设置子按钮最终位置之间的高度距离
//    [self.bar setFarY:30.0f];// 设置子按钮弹出动画弹到的最远高度距离
//    [self.bar setNearY:15.0f];// 设置子按钮弹出动画反弹时的最近高度距离
//    [self.bar setMainAlpha:0.5f];// 设置主按钮未展开时的alpha值
//    [self.bar setMainAnimationTime:0.3f];// 设置主按钮旋转动画时间
    [self.bar setSubAnimationTime:0.4f];//设置子按钮弹出和旋转动画时间
//    [self.bar setDelay:0.1f];// 设置子按钮之间的间隔时间；也影响主按钮延迟改变透明度的时间
    [self.view addSubview:self.bar];
}

// 点击按钮1的响应
- (void)btn1Tap {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"想干啥干啥" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [av show];
}

// 点击按钮2的响应
- (void)btn2Tap {
    [self.bar hideButtonsAnimated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
