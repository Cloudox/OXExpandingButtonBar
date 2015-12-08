//
//  OXExpandingButton.h
//  OXExpandingButton
//
//  Created by Cloudox on 15/12/8.
//  Copyright (c) 2015年 Cloudox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OXExpandingButtonBar : UIView

@property BOOL isExpanding;// 是否点击过
@property (strong, nonatomic) UIButton *mainBtn;// 主按钮
@property (strong, nonatomic) NSArray *buttonArray;// 弹出的按钮数组

/**
 * 初始化bar
 * 参数：mainButton:主按钮；buttons：子按钮数组；center：中心点
**/
- (id) initWithMainButton:(UIButton*)mainButton
                  buttons:(NSArray*)buttons
                   center:(CGPoint)center;

/**
 * 展开子按钮
 **/
- (void)showButtonsAnimated;

/**
 * 收起子按钮
 **/
- (void) hideButtonsAnimated;
@end
