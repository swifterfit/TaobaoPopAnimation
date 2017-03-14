//
//  ViewController.m
//  TaobaoPopAnimation
//
//  Created by Emir on 2017/3/13.
//  Copyright © 2017年 Emir. All rights reserved.
//

#import "ViewController.h"
#import "PopInteraction.h"

@interface ViewController ()

@property (strong, nonatomic) UIButton *showBtn;

@property (strong, nonatomic) UIView *popView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.showBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction {
    [[PopInteraction shareManager] startAnimationRootView:self.view andPopView:self.popView];
}

#pragma mark -
#pragma mark - lazy load

//popView初始化位置在屏幕外部底侧
- (UIView *)popView {
    if (!_popView) {
        _popView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 400)];
        _popView.backgroundColor = [UIColor purpleColor];
    }
    return _popView;
}

- (UIButton *)showBtn {
    if (!_showBtn) {
        _showBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        [_showBtn setTitle:@"show" forState:UIControlStateNormal];
        _showBtn.backgroundColor = [UIColor lightGrayColor];
        [_showBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn;
}
@end
