//
//  PopInteraction.m
//  TaobaoPopAnimation
//
//  Created by Emir on 2017/3/14.
//  Copyright © 2017年 Emir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopInteraction.h"

#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

CGFloat timeInterval = 0.3;

@interface PopInteraction ()

@property (weak, nonatomic) UIView *maskView;
@property (weak, nonatomic) UIView *rootView;
@property (weak, nonatomic) UIView *popView;

@end

@implementation PopInteraction

+ (instancetype)shareManager {
    static PopInteraction *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PopInteraction alloc] init];
    });
    
    return manager;
}

- (void)startAnimationRootView:(UIView *)rootView andPopView:(UIView *)popView {
    
    //添加mask
    UIView * maskView = [[UIView alloc]initWithFrame:kScreenBounds];
    maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    maskView.alpha = 0;
    UITapGestureRecognizer *tap_close = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAnimation)];
    maskView.userInteractionEnabled = YES;
    [maskView addGestureRecognizer:tap_close];
    [kKeyWindow addSubview:maskView];
    
    self.maskView = maskView;
    self.rootView = rootView;
    self.popView =popView;
    
    [kKeyWindow addSubview:popView];
    
    [UIView animateWithDuration:timeInterval animations:^{
        rootView.layer.transform = [self firstTransform];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:timeInterval animations:^{
            rootView.layer.transform = [self secondTransform];
            popView.transform = CGAffineTransformMakeTranslation(0, -popView.frame.size.height);
            self.maskView.alpha = 0.5;
            
        }];
    }];
}

- (void)closeAnimation {
    
    [self.rootView endEditing:YES];
    [UIView animateWithDuration:timeInterval animations:^{
        self.maskView.alpha = 0;
        self.popView.transform = CGAffineTransformIdentity;
        
        self.rootView.layer.transform = [self firstTransform];
    } completion:^(BOOL finished) {
        
        [self.maskView removeFromSuperview];
        [UIView animateWithDuration:timeInterval animations:^{
            
            self.rootView.layer.transform = CATransform3DIdentity;
        }];
    }];
}

- (CATransform3D)firstTransform {
    
    CATransform3D firstTransform = CATransform3DIdentity;
    //透视效果，必须有下面的rotate结合，否则没有效果
    firstTransform.m34 = 1.0/-1500;
    //缩小的效果
    firstTransform = CATransform3DScale(firstTransform, 0.95, 0.95, 1);
    //绕x轴旋转
    firstTransform = CATransform3DRotate(firstTransform, 15.0 * M_PI/180.0, 1, 0, 0);
    //z轴位移
    firstTransform = CATransform3DTranslate(firstTransform, 0, 0, -100);
    
    return firstTransform;
}

- (CATransform3D)secondTransform {
    
    //恢复
    CATransform3D secondTransform = CATransform3DIdentity;
    //再来一次透视
    secondTransform.m34 = [self firstTransform].m34;
    //上移
    secondTransform = CATransform3DTranslate(secondTransform, 0, self.rootView.frame.size.height * (-0.08), 0);
    //再次缩小
    secondTransform = CATransform3DScale(secondTransform, 0.85, 0.75, 1);
    
    return secondTransform;
}

@end
