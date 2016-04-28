//
//  HandlePitureViewController.m
//  CollectionDemo
//
//  Created by GuoWei on 16/4/27.
//  Copyright © 2016年 guowei. All rights reserved.
//

#import "HandlePitureViewController.h"

#define IMAGEHEIGHT     200.0f
#define MAINSCREENWIDTH     320

@interface HandlePitureViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *moreArray;

@end

@implementation HandlePitureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self onInitView];
}

-(void)onInitView {
    UITableView *moreTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    moreTableView.delegate = self;
    moreTableView.dataSource = self;
    moreTableView.contentInset = UIEdgeInsetsMake(IMAGEHEIGHT, 0, 0, 0);
    moreTableView.tableFooterView = [UIView new];
    [self.view addSubview:moreTableView];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -IMAGEHEIGHT, self.view.frame.size.width, IMAGEHEIGHT)];
    _imageView.image = [UIImage imageNamed:@"mybg"];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [moreTableView addSubview:_imageView];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (IMAGEHEIGHT - 80)/2 - IMAGEHEIGHT, 80, 80)];
    headImageView.backgroundColor = [UIColor clearColor];
    headImageView.image = [UIImage imageNamed:@"head"];
    [moreTableView addSubview:headImageView];
    
    UIButton *settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREENWIDTH - 60, 40 - IMAGEHEIGHT, 30, 30)];
    settingBtn.backgroundColor = [UIColor clearColor];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"setting_up@2x"] forState:UIControlStateNormal];
    [moreTableView addSubview:settingBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame) + 20, -IMAGEHEIGHT + 60, 120, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"神奇的哆啦A梦";
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = [UIColor whiteColor];
    [moreTableView addSubview:titleLabel];
    
    if (!_moreArray) {
        _moreArray = [[NSArray alloc]initWithObjects:@"语言",@"体育",@"文艺",@"职业",@"生活",@"爱好", nil];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y; //如果有导航控制器，这里应该加上导航控制器的高度64
    if (y< -IMAGEHEIGHT) {
        CGRect frame = _imageView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _imageView.frame = frame;
    }
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _moreArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [_moreArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
}

#pragma mark - 状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
