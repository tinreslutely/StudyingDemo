//
//  CustomSearchNavigationView.h
//  StudyingDemo
//
//  Created by 李晓毅 on 15/12/17.
//  Copyright © 2015年 李晓毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSearchNavigationView : UIView

@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UIButton *rightButton;

-(instancetype) initWithController:(UIViewController*)controller placeholder:(NSString*)placeholder;
@end
