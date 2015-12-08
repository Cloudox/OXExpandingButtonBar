//
//  OXExpandingButton.h
//  OXExpandingButton
//
//  Created by Cloudox on 15/12/8.
//  Copyright (c) 2015年 Cloudox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OXExpandingButtonBar : UIView
{
    /* ----------------------------------------------
     * 以下属性为可设置属性
     * --------------------------------------------*/
    float _mainRotate;// 主按钮点击展开时旋转到的角度
    float _mainReRotate;// 主按钮点击收回时旋转到的角度
    BOOL _isSpin;// 子按钮是否旋转
}

/* ----------------------------------------------
 * 以下属性为全局使用的属性
 * --------------------------------------------*/
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


/* ----------------------------------------------
 * 以下方法用来设置属性
 * --------------------------------------------*/
/**
 * 设置展开时主按钮旋转到的角度
 **/
- (void)setMainRotate:(float)rotate;

/**
 * 设置收起时主按钮旋转到的角度
 **/
- (void)setMainReRotate:(float)rotate;

/**
 * 设置弹出子按钮时是否旋转子按钮
 **/
- (void)setSpin:(BOOL)b;

@end
