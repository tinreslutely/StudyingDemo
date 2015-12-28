//
//  TestBLKFlexibleHeightBarControllerViewController.m
//  StudyingDemo
//
//  Created by 李晓毅 on 15/12/25.
//  Copyright © 2015年 李晓毅. All rights reserved.
//

#import "TestBLKFlexibleHeightBarControllerViewController.h"
#import "FacebookStyleBar.h"
#import "FacebookStyleBarBehaviorDefiner.h"

@interface TestBLKFlexibleHeightBarControllerViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TestBLKFlexibleHeightBarControllerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setNeedsStatusBarAppearanceUpdate];
    
    FacebookStyleBar *myBar = [[FacebookStyleBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 100.0)];
    
    myBar.backgroundColor = [UIColor colorWithRed:0.86 green:0.25 blue:0.23 alpha:1];
    
    
    [self.view addSubview:myBar];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(50, 0, 0, 0));
    }];
    
    
    FacebookStyleBarBehaviorDefiner *behaviorDefiner = [[FacebookStyleBarBehaviorDefiner alloc] init];
    [behaviorDefiner addSnappingPositionProgress:0.0 forProgressRangeStart:0.0 end:40.0/(105.0-20.0)];
    [behaviorDefiner addSnappingPositionProgress:1.0 forProgressRangeStart:40.0/(105.0-20.0) end:1.0];
    behaviorDefiner.snappingEnabled = YES;
    behaviorDefiner.thresholdNegativeDirection = 140.0;
    ((UIScrollView *)tableView).delegate = behaviorDefiner;
    myBar.behaviorDefiner = behaviorDefiner;
    
    
    // Add a close button to the bar
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    closeButton.userInteractionEnabled = YES;
    closeButton.tintColor = [UIColor whiteColor];
    [closeButton setImage:[UIImage imageNamed:@"Close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *initialCloseButtonLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
    initialCloseButtonLayoutAttributes.frame = CGRectMake(myBar.frame.size.width - 35.0, 26.5, 30.0, 30.0);
    initialCloseButtonLayoutAttributes.zIndex = 1024;
    
    [closeButton addLayoutAttributes:initialCloseButtonLayoutAttributes forProgress:0.0];
    [closeButton addLayoutAttributes:initialCloseButtonLayoutAttributes forProgress:40.0/(105.0-20.0)];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalCloseButtonLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialCloseButtonLayoutAttributes];
    finalCloseButtonLayoutAttributes.transform = CGAffineTransformMakeTranslation(0.0, -0.3*(105-20));
    finalCloseButtonLayoutAttributes.alpha = 0.0;
    
    [closeButton addLayoutAttributes:finalCloseButtonLayoutAttributes forProgress:0.8];
    [closeButton addLayoutAttributes:finalCloseButtonLayoutAttributes forProgress:1.0];
    
    [myBar addSubview:closeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
