//
//  PopInteraction.h
//  TaobaoPopAnimation
//
//  Created by Emir on 2017/3/14.
//  Copyright © 2017年 Emir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopInteraction : NSObject

+ (instancetype)shareManager;


/**
 传入凹陷的rootView和底部弹出的popView

 @param rootView 底层凹陷的View
 @param popView 底部弹出的View
 */
- (void)startAnimationRootView:(UIView *)rootView andPopView:(UIView *)popView;

- (void)closeAnimation;

@end
