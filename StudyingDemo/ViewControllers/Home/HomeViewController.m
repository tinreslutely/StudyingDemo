//
//  HomeViewController.m
//  StudyingDemo
//
//  Created by 李晓毅 on 15/12/16.
//  Copyright © 2015年 李晓毅. All rights reserved.
//

#import "HomeViewController.h"

#import "BaseAnimationViewController.h"
#import "TestCustomNavigationController.h"
#import "TestBLKFlexibleHeightBarControllerViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"基础" image:[UIImage imageNamed:@"home"] tag:0]];
    [self.navigationItem setTitle:@"基础"];
    
    [self initView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[BaseAnimationViewController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[TestCustomNavigationController alloc] init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[TestBLKFlexibleHeightBarControllerViewController alloc] init] animated:YES];
            break;
        default:
            break;
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    switch (indexPath.row) {
        case 0:
            [cell.textLabel setText:@"动画"];
            break;
        case 1:
            [cell.textLabel setText:@"自定义导航栏"];
            break;
        case 2:
            [cell.textLabel setText:@"BLKFlexibleHeightBar导航栏"];
            break;
            
        default:
            break;
    }
    return cell;
}

-(void)initView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [self.view addSubview:tableView];
}



@end
