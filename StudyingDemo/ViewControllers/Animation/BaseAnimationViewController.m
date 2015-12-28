//
//  BaseAnimationViewController.m
//  StudyingDemo
//
//  Created by 李晓毅 on 15/12/17.
//  Copyright © 2015年 李晓毅. All rights reserved.
//

#import "BaseAnimationViewController.h"

@interface BaseAnimationViewController ()

@end

@implementation BaseAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    [self initScaleLayer];
//    [self initGroupLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)initRectLayer{
    CALayer *rectLayer = [[CALayer alloc] init];
    [rectLayer setFrame:CGRectMake(15, 200, 30, 30)];
    [rectLayer setCornerRadius:15];
    [rectLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
    [self.view.layer addSublayer:rectLayer];
    
    CAKeyframeAnimation *rectRunAnimation = [CAKeyframeAnimation animationWithKeyPath:@"postion"];
    rectRunAnimation.values = @[[NSValue valueWithCGPoint:rectLayer.frame.origin],[NSValue valueWithCGPoint:CGPointMake(320-15,rectLayer.frame.origin.y)]];
    
}


-(void)initScaleLayer{
    float kYOffset = 64;
    CALayer *scaleLayer = [[CALayer alloc] init];
    scaleLayer.backgroundColor = [[UIColor blueColor] CGColor];
    [scaleLayer setFrame:CGRectMake(120, 20 + kYOffset, 50, 50)];
    [scaleLayer setCornerRadius:5];
    [self.view.layer  addSublayer:scaleLayer];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.5];
    scaleAnimation.toValue = [NSNumber numberWithFloat:2.5];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeBackwards;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    [scaleLayer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

-(void)initGroupLayer{
    CALayer *groupLayer = [[CALayer alloc] init];
    [groupLayer setFrame:CGRectMake(60, 340 + 100, 50, 50)];
    [groupLayer setCornerRadius:10];
    [groupLayer setBackgroundColor:[[UIColor purpleColor] CGColor]];
    [self.view.layer addSublayer:groupLayer];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;//动画结束时的速度变化
    scaleAnimation.repeatCount = MAXFLOAT;//重复次数
    scaleAnimation.duration = 0.8;//动画时长
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:groupLayer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(320-80, groupLayer.position.y)];
    moveAnimation.autoreverses = YES;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.duration = 8;
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0*M_PI];
    rotateAnimation.duration = 2;
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.autoreverses = YES;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 8;
    groupAnimation.autoreverses = YES;
    groupAnimation.repeatCount = MAXFLOAT;
    [groupAnimation setAnimations:@[moveAnimation,scaleAnimation,rotateAnimation]];
    
    [groupLayer addAnimation:groupAnimation forKey:@"groupAnimation"];
    
}

@end
