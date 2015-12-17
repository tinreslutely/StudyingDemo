//
//  UtilsMacro.h
//  MicroValuePurchase
//  定义方法宏
//  Created by 李晓毅 on 15/10/23.
//  Copyright (c) 2015年 TureTop. All rights reserved.
//

#ifndef MicroValuePurchase_UtilsMacro_h
#define MicroValuePurchase_UtilsMacro_h

#define USER_GLOBAL [MDGlobalUserData sharedGlobalData]

#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

/***********************颜色**********************/

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//rgb颜色
#define UIColorFromRGBA(r,g,b,a)([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)])
//
#define UIColorFromRGB(r,g,b)(UIColorFromRGBA(r,g,b,1.0))
//tab item名称默认状态
#define TAB_COLOR UIColorFromRGB(51.0,51.0,51.0)
//tab item名称选中状态颜色
#define TAB_SEL_COLOR UIColorFromRGB(252.0,80.0,2.0)
//nav标题文字颜色
#define GRAY_COLOR UIColorFromRGB(129.0,129.0,129.0)
//文本输入框
#define INPUT_COLOR UIColorFromRGB(106.0,106.0,106.0)


/***********************尺寸**********************/
//导航栏高度
#define NAV_HEIGHT 44
//tabbar高度
#define TAB_HEIGHT 50
//状态栏高度
#define STARTBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
//屏幕bounds
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
//屏幕宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/***********************系统版本**********************/
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/***********************提示**********************/
#define ALERT(msg)([[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TitleForTips", @"") message:(msg) delegate:self cancelButtonTitle:NSLocalizedString(@"TitleForConfirm", @"") otherButtonTitles:nil] show])
#endif

/***********************单例化一个类**********************/
#define SINGLETON_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

//判断是否真机
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

