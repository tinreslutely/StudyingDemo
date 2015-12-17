//
//  TestCustomNavigationController.m
//  StudyingDemo
//
//  Created by 李晓毅 on 15/12/17.
//  Copyright © 2015年 李晓毅. All rights reserved.
//

#import "TestCustomNavigationController.h"
#import "CustomSearchNavigationView.h"

@interface TestCustomNavigationController ()

@end

@implementation TestCustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CustomSearchNavigationView *customNaviBarView = [[CustomSearchNavigationView alloc] initWithController:self placeholder:@"搜索商品"];
//    if (customNaviBarView != nil)
//    {
//        [customNaviBarView.leftButton addTarget:self action:@selector(cancelButtonEventTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
//        [customNaviBarView.rightButton addTarget:self action:@selector(addButtonEventTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:customNaviBarView];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
