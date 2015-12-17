//
//  CustomSearchNavigationView.m
//  StudyingDemo
//
//  Created by 李晓毅 on 15/12/17.
//  Copyright © 2015年 李晓毅. All rights reserved.
//

#import "CustomSearchNavigationView.h"

#define CUSTOM_NAV_HEIGHT 44;
@interface CustomSearchNavigationView()<UITextFieldDelegate>

@end

@implementation CustomSearchNavigationView

-(instancetype) initWithController:(UIViewController*)controller placeholder:(NSString*)placeholder{
    float height = NAV_HEIGHT - 10;
    float top = STARTBAR_HEIGHT + 5;
    if(self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)]){
        
        [self setBackgroundColor:[UIColor redColor]];
        //[controller.navigationController setNavigationBarHidden:YES animated:YES];
        //左边按钮
        _leftButton = [[UIButton alloc] init];
        [_leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_leftButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
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
            make.size.mas_equalTo(CGSizeMake(view.frame.size.height-8, view.frame.size.height-8));
            make.top.equalTo(view.mas_top).with.offset(4);
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
            make.centerY.equalTo(view);
            make.left.equalTo(button.mas_right).with.offset(2);
            make.right.equalTo(view.mas_right).with.offset(5);
        }];
        
        //底部线
        UIView *dividingLine = [[UIView alloc] init];
        [dividingLine setBackgroundColor:UIColorFromRGBA(221, 221, 221, 1)];
        [self addSubview:dividingLine];
        [dividingLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
        }];
        
        [controller.navigationController.navigationBar setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 108)];
        controller.navigationItem.leftBarButtonItem = nil;
        [controller.navigationItem setTitleView:self];
//        [controller.view addSubview:self];
//        [controller.view bringSubviewToFront:self];
    }
    return self;
}

@end
