//
//  MenuTableViewController.m
//  CollectionDemo
//
//  Created by guowei on 15/7/29.
//  Copyright (c) 2015年 guowei. All rights reserved.
//

#import "MenuTableViewController.h"
#import "ViewController.h"
#import "NotePadViewController.h"
#import "CalculatorViewController.h"
#import "CalendarViewController.h"
#import "HandlePitureViewController.h"

@interface MenuTableViewController ()

@property (nonatomic, strong) NSArray *menuArray;

@property (nonatomic, strong) UIImageView *topView;

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:42/255.f green:110/255.f blue:180/255.f alpha:1.f]; //[UIColor colorWithRed:219/255.f green:185/255.f blue:124/255.f alpha:1.f];
    self.tableView.tableFooterView = [UIView new]; //防止下面的部分出现分割线
    
    
    [self initData];
}

- (void)initData {
    /*
     1、计算器
     2、记事本
     3、图片添加表情
     4、日历
     5、通讯录
     */
    
    _menuArray = [[NSArray alloc] initWithObjects:@"", @"日历", @"记事本", @"计算器", @"通讯录", @"图片添加表情", nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_menuArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row != 0) {
        //目录名
        cell.textLabel.text = [_menuArray objectAtIndex:indexPath.row];
        //目录图片
        cell.imageView.image = [UIImage imageNamed:@"head"];
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    if (indexPath.row == 1) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[CalendarViewController alloc] init]];
        self.revealController.frontViewController = nav;
        [self.revealController showViewController:self.revealController.frontViewController];
    }
    else if (indexPath.row == 2) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[NotePadViewController alloc] init]];
        self.revealController.frontViewController = nav;
        [self.revealController showViewController:self.revealController.frontViewController];
    }
    else if (indexPath.row == 3) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[CalculatorViewController alloc] init]];
        self.revealController.frontViewController = nav;
        [self.revealController showViewController:self.revealController.frontViewController];
    }
    else if (indexPath.row == 4) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
        self.revealController.frontViewController = nav;
        [self.revealController showViewController:self.revealController.frontViewController];
    }
    else if (indexPath.row == 5) {
        HandlePitureViewController *vc = [[HandlePitureViewController alloc] init];
        self.revealController.frontViewController = vc;
        [self.revealController showViewController:self.revealController.frontViewController];
    }
    
}



@end
