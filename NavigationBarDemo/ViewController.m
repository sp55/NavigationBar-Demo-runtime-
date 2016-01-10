//
//  ViewController.m
//  NavigationBarDemo
//
//  Created by admin on 16/1/10.
//  Copyright © 2016年 AlezJi. All rights reserved.
//


//http://www.jianshu.com/p/6f3bc1da18f3

/*
 -注意图片的frame y 是-64 ，也就是在UINavigationBar后面
 SecondViewController中的图片的frame y 就是 0
 

 tableView 的 tableViewCell 有几种不同的类型  ，basic  custom  ...
 
 颜色在Appdelegate中设置了
 
 
 
 
 UINavigationBar+Ext
 中封装了两种不同的方法，用来隐藏UINavigationBar
 
 */
#import "ViewController.h"
#import "UINavigationBar+Ext.h"

#define kNavBarChangePoint 50


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"0ffset****%f",offsetY);
    if (offsetY > kNavBarChangePoint) {
        CGFloat alpha = MIN(1, 1 - ((kNavBarChangePoint + 64 - offsetY) / 64));

        // MIN(<#A#>, <#B#>)  是个系统自带的类似于三木运算符之类的东西 ,最小值在1 和 ((kNavBarChangePoint + 64 - offsetY) / 64) 产生
//        NSLog(@"*****%f",1 - ((kNavBarChangePoint + 64 - offsetY) / 64));
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    //重置  不占用内存
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark UITableViewDatasource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"header";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"text";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


@end
