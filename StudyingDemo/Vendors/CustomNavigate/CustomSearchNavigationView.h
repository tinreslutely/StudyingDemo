//
//  CustomSearchNavigationView.h
//  StudyingDemo
//
//  Created by 李晓毅 on 15/12/17.
//  Copyright © 2015年 李晓毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSearchNavigationView;
@protocol CustomSearchNavigationViewDelegate <NSObject>

-(void)customSearchNavigationView:(CustomSearchNavigationView*)customSearchNavigationView didTouchDownEventWithLeftButton:(UIButton*)button;
-(void)customSearchNavigationView:(CustomSearchNavigationView*)customSearchNavigationView didTouchDownEventWithRightButton:(UIButton*)button;
-(void)customSearchNavigationView:(CustomSearchNavigationView*)customSearchNavigationView didBeginEditingWithTextField:(UITextField*)textField;

@end

@interface CustomSearchNavigationView : UIView

@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIViewController *currentController;
@property(nonatomic,strong)id<CustomSearchNavigationViewDelegate> delegate;

-(instancetype) initWithController:(UIViewController*)controller placeholder:(NSString*)placeholder;
-(void)setBottomView:(UIView *)bottomView width:(float)width height:(float)height topMargin:(float)topMargin;
-(void)returnNavigation;
@end
