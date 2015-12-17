//
//  CustomNavigationView.m
//  StudyingDemo
//
//  Created by 李晓毅 on 15/12/17.
//  Copyright © 2015年 李晓毅. All rights reserved.
//

#import "CustomNavigationView.h"

#define WIDTH_SCREEN [[UIScreen mainScreen] bounds].size.width
#define POST_CANCEL_BUTTON @"返回"
#define macro

@implementation CustomNavigationView

#pragma mark life cycle
-(instancetype) initWithController:(UIViewController*)controller{
    if(self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)]){
        [self setBackgroundColor:UIColorFromRGBA(248, 248, 248, 1)];
        [controller.navigationController setNavigationBarHidden:YES animated:YES];
        
        //左边按钮
        _leftButton = [[UIButton alloc] init];
        [_leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_leftButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self addSubview:_leftButton];
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 44));
            make.left.equalTo(self.mas_left).with.offset(0);
            make.top.equalTo(self.mas_top).with.offset(0);
        }];
        
        //右边按钮
        _rightButton = [[UIButton alloc] init];
        [_rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 44));
            make.right.equalTo(self.mas_right).with.offset(0);
            make.top.equalTo(self.mas_top).with.offset(0);
        }];
        
        
        //中间显示UILabel控件
        _navTitle = [[UILabel alloc] init];
        [_navTitle setFont:[UIFont systemFontOfSize:18]];
        [_navTitle setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_navTitle];
        [_navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.left.equalTo(_leftButton.mas_right).with.offset(0);
            make.right.equalTo(_rightButton.mas_left).with.offset(0);
            make.top.equalTo(self.mas_top).with.offset(0);
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
        
        [controller.view addSubview:self];
        [controller.view bringSubviewToFront:self];
    }
    return self;
}

#pragma mark public methods
-(void)setLeftButtonWithTitle:(NSString*)title{
    [_leftButton setTitle:title forState:UIControlStateNormal];
}

-(void)setLeftButtonWithImageName:(NSString*)imageName{
    [_leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

-(void)setTitle:(NSString*)title{
    [_navTitle setText:title];
}


@end
