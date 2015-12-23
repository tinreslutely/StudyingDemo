//
//  CustomSearchNavigationView.m
//  StudyingDemo
//
//  Created by 李晓毅 on 15/12/17.
//  Copyright © 2015年 李晓毅. All rights reserved.
//

#import "CustomSearchNavigationView.h"
#import "UINavigationBar+Awesome.h"

@interface CustomSearchNavigationView()<UITextFieldDelegate>

@end

@implementation CustomSearchNavigationView

#pragma mark life cycle
-(instancetype) initWithController:(UIViewController*)controller placeholder:(NSString*)placeholder{
    float height = NAV_HEIGHT - 10;
    float top = 5;
    _currentController = controller;
    if(self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_HEIGHT)]){
        //左边按钮
        _leftButton = [[UIButton alloc] init];
        [_leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_leftButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_leftButton setImage:[UIImage imageNamed:@"arrow_back"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonTap:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_leftButton];
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, height));
            make.left.equalTo(self.mas_left).with.offset(0);
            make.top.equalTo(self.mas_top).with.offset(top);
        }];
        
        //右边按钮
        _rightButton = [[UIButton alloc] init];
        [_rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_rightButton addTarget:self action:@selector(rightButtonTap:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, height));
            make.right.equalTo(self.mas_right).with.offset(0);
            make.top.equalTo(self.mas_top).with.offset(top);
        }];
        
        
        //中间显示搜索控件
        UIView *view = [[UIView alloc] init];
        [view.layer setBorderWidth:0.5];
        [view.layer setBorderColor:[UIColorFromRGBA(221, 221, 221, 1) CGColor]];
        [view.layer setCornerRadius:5];
        [view.layer setMasksToBounds:YES];
        [view setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
            make.left.equalTo(_leftButton.mas_right).with.offset(0);
            make.right.equalTo(_rightButton.mas_left).with.offset(0);
            make.top.equalTo(self.mas_top).with.offset(top);
        }];
        
        UIButton *button = [[UIButton alloc] init];
        [button setBackgroundImage:[UIImage imageNamed:@"searchIcon"] forState:UIControlStateNormal];
        [button setEnabled:NO];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(height-12, height-12));
            make.centerY.equalTo(view);
            make.left.equalTo(view.mas_left).with.offset(4);
        }];
        //添加一个文本输入框
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = placeholder;
        textField.font = [UIFont systemFontOfSize:12];
        textField.delegate = self;
        textField.tag = 2000;
        [view addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
            make.centerY.equalTo(view);
            make.left.equalTo(button.mas_right).with.offset(5);
            make.right.equalTo(view.mas_right).with.offset(5);
        }];
        
        
        [self setupNavigationBar];
        [controller.navigationItem setTitleView:self];
    }
    return self;
}

#pragma mark UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if([self.delegate respondsToSelector:@selector(customSearchNavigationView:didBeginEditingWithTextField:)]){
        [self.delegate customSearchNavigationView:self didBeginEditingWithTextField:textField];
    }
}

#pragma mark action event methods
-(void)leftButtonTap:(UIButton*)button{
    if([self.delegate respondsToSelector:@selector(customSearchNavigationView:didTouchDownEventWithLeftButton:)]){
        [self.delegate customSearchNavigationView:self didTouchDownEventWithLeftButton:button];
    }
}
-(void)rightButtonTap:(UIButton*)button{
    if([self.delegate respondsToSelector:@selector(customSearchNavigationView:didTouchDownEventWithRightButton:)]){
        [self.delegate customSearchNavigationView:self didTouchDownEventWithRightButton:button];
    }
}


#pragma mark public methods
-(void)setBottomView:(UIView *)bottomView width:(float)width height:(float)height topMargin:(float)topMargin{
    _bottomView = bottomView;
    [self addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.bottom.equalTo(self.mas_bottom).with.offset(-2);
        make.centerX.equalTo(self);
    }];
    float navHeight = NAV_HEIGHT + topMargin + height;
    [_currentController.navigationItem.titleView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, navHeight)];
    [_currentController.navigationController.navigationBar setFrame:CGRectMake(0, 0, SCREEN_WIDTH, navHeight+20)];
    [_currentController.navigationController.navigationBar setTitleVerticalPositionAdjustment:-20 forBarMetrics:UIBarMetricsDefault];
}

-(void)returnNavigation{
    CGRect frame = _currentController.navigationController.navigationBar.frame;
    [_currentController.navigationController.navigationBar setFrame:CGRectMake(0, 0, frame.size.width, NAV_HEIGHT + STARTBAR_HEIGHT)];
    [_currentController.navigationController.navigationBar setTitleVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
}

#pragma mark private methods
-(void)setupNavigationBar{
    //隐藏导航栏左右两侧的按钮
    if(SYSTEM_VERSION > 7){
        UIBarButtonItem *navigiateSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        navigiateSpacer.width = -22;
        _currentController.navigationItem.leftBarButtonItems = @[navigiateSpacer,[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]]];
        
        navigiateSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        navigiateSpacer.width = -16;
        _currentController.navigationItem.rightBarButtonItems = @[navigiateSpacer,[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]]];
        
    }else{
        [_currentController.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]]];
        [_currentController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]]];
    }
    [_currentController.navigationItem setTitleView:self];
}


@end
