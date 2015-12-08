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
    
    self.bar = [[OXExpandingButtonBar alloc] initWithMainButton:mainBtn buttons:buttons center:center];
    [self.view addSubview:self.bar];
}

// 点击按钮1的响应
- (void)btn1Tap {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"旋转，跳跃，我闭着眼" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
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
