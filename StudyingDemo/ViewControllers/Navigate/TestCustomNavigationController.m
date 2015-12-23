//
//  TestCustomNavigationController.m
//  StudyingDemo
//
//  Created by 李晓毅 on 15/12/17.
//  Copyright © 2015年 李晓毅. All rights reserved.
//

#import "TestCustomNavigationController.h"
#import "CustomSearchNavigationView.h"
#import "UINavigationBar+Awesome.h"

#define NAVBAR_CHANGE_POINT 50

@interface TestCustomNavigationController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TestCustomNavigationController{
    CustomSearchNavigationView *_customNaviBarView;
    float _scrollPointStartY;
    float _scrollPointEndY;
}
static char overlayKey;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    _customNaviBarView = [[CustomSearchNavigationView alloc] initWithController:self placeholder:@"搜索商品"];
    [_customNaviBarView setBottomView:[self createViewForCustomConditionWithWidth:SCREEN_WIDTH] width:SCREEN_WIDTH height:30 topMargin:5];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_customNaviBarView returnNavigation];
    [self.navigationController.navigationBar lt_reset];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _scrollPointStartY = scrollView.contentOffset.y;
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    float height = self.navigationController.navigationBar.frame.size.height;
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat rollY = offsetY - _scrollPointStartY;
    if (rollY > 0) {
        if (offsetY >= height) {
            [self setNavigationBarTransformProgress:1];
        }
    } else {
        [self setNavigationBarTransformProgress:0];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    }
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    float height = self.navigationController.navigationBar.frame.size.height;
    [self.navigationController.navigationBar lt_setTranslationY:(-1 * height * progress)];
    [self.navigationController.navigationBar lt_setElementsAlpha:(1-progress)];
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 113;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell.textLabel setText:@"动画"];
    return cell;
}


/**
 *  添加一个自定义的排序条件的UIView
 *
 *  @param superView 父级UIView
 *  @param height    UIView的高度
 *
 *  @return UIView对象
 */
-(UIView*)createViewForCustomConditionWithWidth:(CGFloat)width{
    UIView *conditionView = [[UIView alloc] init];
    
    float itemWidth = (width/3)-1;
    //销量
    UIButton *salesButton = [[UIButton alloc] init];
    [[salesButton titleLabel] setFont:[UIFont systemFontOfSize:14]];
    [salesButton setTitle:@"销量" forState:UIControlStateNormal];
    [salesButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    salesButton.tag = 1001;
    [salesButton addTarget:self action:@selector(sortButtonTap:) forControlEvents:UIControlEventTouchDown];
    [conditionView addSubview:salesButton];
    [salesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(itemWidth);
        make.top.equalTo(conditionView.mas_top).with.offset(1);
        make.bottom.equalTo(conditionView.mas_bottom).with.offset(1);
        make.left.equalTo(conditionView.mas_left).with.offset(0);
    }];
    
    UILabel *sepLabel = [[UILabel alloc] init];
    [sepLabel setBackgroundColor:UIColorFromRGBA(204, 204, 204, 1)];
    [conditionView addSubview:sepLabel];
    [sepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.equalTo(conditionView.mas_top).with.offset(5);
        make.bottom.equalTo(conditionView.mas_bottom).with.offset(-5);
        make.left.equalTo(salesButton.mas_right).with.offset(0);
    }];
    
    //价格
    UIButton *priceSortButton = [[UIButton alloc] init];
    [priceSortButton addTarget:self action:@selector(sortButtonTap:) forControlEvents:UIControlEventTouchDown];
    [priceSortButton setTag:1002];
    [[priceSortButton titleLabel] setFont:[UIFont systemFontOfSize:14]];
    [priceSortButton setTitle:@"价格" forState:UIControlStateNormal];
    [priceSortButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [priceSortButton setImageEdgeInsets:UIEdgeInsetsMake(0, (itemWidth/2)+20, 0, 0)];
    [conditionView addSubview:priceSortButton];
    [priceSortButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(itemWidth);
        make.top.equalTo(conditionView.mas_top).with.offset(1);
        make.bottom.equalTo(conditionView.mas_bottom).with.offset(1);
        make.left.equalTo(salesButton.mas_right).with.offset(0);
    }];
    
    sepLabel = [[UILabel alloc] init];
    [sepLabel setBackgroundColor:UIColorFromRGBA(204, 204, 204, 1)];
    [conditionView addSubview:sepLabel];
    [sepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.equalTo(conditionView.mas_top).with.offset(5);
        make.bottom.equalTo(conditionView.mas_bottom).with.offset(-5);
        make.left.equalTo(priceSortButton.mas_right).with.offset(0);
    }];
    
    //最新
    UIButton *newSortButton = [[UIButton alloc] init];
    [[newSortButton titleLabel] setFont:[UIFont systemFontOfSize:14]];
    [newSortButton setTitle:@"最新" forState:UIControlStateNormal];
    [newSortButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [newSortButton addTarget:self action:@selector(sortButtonTap:) forControlEvents:UIControlEventTouchDown];
    newSortButton.tag = 1003;
    [conditionView addSubview:newSortButton];
    [newSortButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(itemWidth);
        make.top.equalTo(conditionView.mas_top).with.offset(1);
        make.bottom.equalTo(conditionView.mas_bottom).with.offset(1);
        make.left.equalTo(priceSortButton.mas_right).with.offset(0);
    }];
    return conditionView;
}


@end
