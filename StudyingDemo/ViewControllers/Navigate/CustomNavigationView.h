//
//  CustomNavigationView.h
//  StudyingDemo
//
//  Created by 李晓毅 on 15/12/17.
//  Copyright © 2015年 李晓毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomNavigationView;

@protocol CustomNavigationViewDelegate <NSObject>

@optional


@end

@interface CustomNavigationView : UIView

@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)UILabel *navTitle;

-(instancetype) initWithController:(UIViewController*)controller;
@end
