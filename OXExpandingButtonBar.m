//
//  OXExpandingButton.m
//  OXExpandingButton
//
//  Created by Cloudox on 15/12/8.
//  Copyright (c) 2015年 Cloudox. All rights reserved.
//

#import "OXExpandingButtonBar.h"

@implementation OXExpandingButtonBar

- (id) initWithMainButton:(UIButton*)mainButton buttons:(NSArray*)buttons center:(CGPoint)center {
    if (self = [super init]) {
        [self setDefaults];// 设置默认数值
        
        CGRect buttonFrame = CGRectMake(0, 0, mainButton.frame.size.width, mainButton.frame.size.height);
        CGPoint buttonCenter = CGPointMake(mainButton.frame.size.width / 2.0f, mainButton.frame.size.height / 2.0f);
        
        self.isExpanding = NO;
        
        // 主按钮
        self.mainBtn = mainButton;
        [self.mainBtn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainBtn setCenter:buttonCenter];
        
        // 子按钮
        self.buttonArray = [[buttons reverseObjectEnumerator] allObjects];
        for (int i = 0; i < [self.buttonArray count]; i++) {
            UIButton *button = [self.buttonArray objectAtIndex:i];
            [button setCenter:buttonCenter];
            [button setAlpha:0.0f];
            [self addSubview:button];
        }
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setFrame:buttonFrame];
        [self setCenter:center];
        [self addSubview:self.mainBtn];
    }
    return self;
}

// 设置默认数值
- (void)setDefaults {
    /*关于M_PI
     #define M_PI     3.14159265358979323846264338327950288
     其实它就是圆周率的值，在这里代表弧度，相当于角度制 0-360 度，M_PI=180度
     旋转方向为：顺时针旋转
     */
    
    _mainRotate = 0.0f;
    _mainReRotate = - M_PI*(45)/180.0;
    _isSpin = YES;
}

// 点击主按钮的响应
- (void)btnTap:(UIButton *)sender {
    if (!self.isExpanding) {// 初始未展开
        [self showButtonsAnimated];
    } else {// 已展开
        [self hideButtonsAnimated];
    }
}

// 展开按钮
- (void)showButtonsAnimated {
    // 主按钮旋转动画
    CGAffineTransform angle = CGAffineTransformMakeRotation (_mainRotate);
    [UIView animateWithDuration:0.3 animations:^{// 动画开始
        [self.mainBtn setTransform:angle];
    } completion:^(BOOL finished){// 动画结束
        [self.mainBtn setTransform:angle];
    }];
    
    float y = [self.mainBtn center].y;
    float x = [self.mainBtn center].x;
    float endY = y;
    float endX = x;
    for (int i = 0; i < [self.buttonArray count]; ++i) {
        UIButton *button = [self.buttonArray objectAtIndex:i];
        // 最终坐标
        endY -= button.frame.size.height + 30.0f;
        endX += 0.0f;
        // 反弹坐标
        float farY = endY - 30.0f;
        float farX = endX - 0.0f;
        float nearY = endY + 15.0f;
        float nearX = endX + 0.0f;
        
        // 动画集合
        NSMutableArray *animationOptions = [NSMutableArray array];
        
        if (_isSpin) {// 旋转动画
            CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
            [rotateAnimation setValues:[NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:M_PI * 2], nil]];
            [rotateAnimation setDuration:0.4f];
            [rotateAnimation setKeyTimes:[NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f], nil]];
            [animationOptions addObject:rotateAnimation];
        }
        
        // 位置动画
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        [positionAnimation setDuration:0.4f];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, x, y);
        CGPathAddLineToPoint(path, NULL, farX, farY);
        CGPathAddLineToPoint(path, NULL, nearX, nearY);
        CGPathAddLineToPoint(path, NULL, endX, endY);
        [positionAnimation setPath: path];
        CGPathRelease(path);
        [animationOptions addObject:positionAnimation];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        [animationGroup setAnimations: animationOptions];
        [animationGroup setDuration:0.4f];
        [animationGroup setFillMode: kCAFillModeForwards];
        [animationGroup setTimingFunction: [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        
        NSDictionary *properties = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:button, [NSValue valueWithCGPoint:CGPointMake(endX, endY)], animationGroup, nil] forKeys:[NSArray arrayWithObjects:@"view", @"center", @"animation", nil]];
        
        [self performSelector:@selector(_expand:) withObject:properties afterDelay:0.1f * ([self.buttonArray count] - i)];
    }
    self.isExpanding = YES;// 设为已展开
}

// 收起动画
- (void) hideButtonsAnimated {
    // 主按钮旋转动画
    CGAffineTransform unangle = CGAffineTransformMakeRotation (_mainReRotate);
    [UIView animateWithDuration:0.3 animations:^{// 动画开始
        [self.mainBtn setTransform:unangle];
    } completion:^(BOOL finished){// 动画结束
        [self.mainBtn setTransform:unangle];
    }];
    
    CGPoint center = [self.mainBtn center];
    float endY = center.y;
    float endX = center.x;
    for (int i = 0; i < [self.buttonArray count]; ++i) {
        UIButton *button = [self.buttonArray objectAtIndex:i];
        
        // 动画集合
        NSMutableArray *animationOptions = [NSMutableArray array];
        
        if (_isSpin) {// 旋转动画
            CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
            [rotateAnimation setValues:[NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:M_PI * -2], nil]];
            [rotateAnimation setDuration:0.4f];
            [rotateAnimation setKeyTimes:[NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f], nil]];
            [animationOptions addObject:rotateAnimation];
        }
        
        // 透明度？
        CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        [opacityAnimation setValues:[NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0f], [NSNumber numberWithFloat:0.0f], nil]];
        [opacityAnimation setDuration:0.4];
        [animationOptions addObject:opacityAnimation];
        
        // 位置动画
        float y = [button center].y;
        float x = [button center].x;
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        [positionAnimation setDuration:0.4f];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, x, y);
        CGPathAddLineToPoint(path, NULL, endX, endY);
        [positionAnimation setPath: path];
        CGPathRelease(path);
        [animationOptions addObject:positionAnimation];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        [animationGroup setAnimations: animationOptions];
        [animationGroup setDuration:0.4f];
        [animationGroup setFillMode: kCAFillModeForwards];
        [animationGroup setTimingFunction: [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        
        NSDictionary *properties = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:button, animationGroup, nil] forKeys:[NSArray arrayWithObjects:@"view", @"animation", nil]];
        [self performSelector:@selector(_close:) withObject:properties afterDelay:0.1f * ([self.buttonArray count] - i)];
    }
    self.isExpanding = NO;// 设为未展开
}

// 弹出
- (void) _expand:(NSDictionary*)properties
{
    UIView *view = [properties objectForKey:@"view"];
    CAAnimationGroup *animationGroup = [properties objectForKey:@"animation"];
    NSValue *val = [properties objectForKey:@"center"];
    CGPoint center = [val CGPointValue];
    [[view layer] addAnimation:animationGroup forKey:@"Expand"];
    [view setCenter:center];
    [view setAlpha:1.0f];
}

// 收起
- (void) _close:(NSDictionary*)properties
{
    UIView *view = [properties objectForKey:@"view"];
    CAAnimationGroup *animationGroup = [properties objectForKey:@"animation"];
    CGPoint center = [self.mainBtn center];
    [[view layer] addAnimation:animationGroup forKey:@"Collapse"];
    [view setAlpha:0.0f];
    [view setCenter:center];
}


/* ----------------------------------------------
 * 以下方法为设置时用到的方法
 * --------------------------------------------*/
- (void)setMainRotate:(float)rotate {
    _mainRotate = rotate;
}

- (void)setMainReRotate:(float)rotate {
    _mainReRotate = rotate;
}

- (void)setSpin:(BOOL)b {
    _isSpin = b;
}


/* ----------------------------------------------
 * DO NOT CHANGE
 * The following is a hack to allow touches outside
 * of this view. Use caution when changing.
 * --------------------------------------------*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *v = nil;
    v = [super hitTest:point withEvent:event];
    return v;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL isInside = [super pointInside:point withEvent:event];
    if (YES == isInside) {
        return isInside;
    }
    for (UIButton *button in self.buttonArray) {
        CGPoint inButtonSpace = [self convertPoint:point toView:button];
        BOOL isInsideButton = [button pointInside:inButtonSpace withEvent:nil];
        if (YES == isInsideButton) {
            return isInsideButton;
        }
    }
    return isInside;
}


@end
