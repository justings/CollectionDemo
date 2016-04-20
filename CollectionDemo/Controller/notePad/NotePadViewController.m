//
//  NotePadViewController.m
//  CollectionDemo
//
//  Created by guowei on 15/6/1.
//  Copyright (c) 2015年 guowei. All rights reserved.
//

#import "NotePadViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "TakeNoteViewController.h"

#import "Note.h"
#import "NoteTableViewCell.h"


@interface NotePadViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSInteger num;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation NotePadViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initData];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"哆啦A梦的记事本";
    self.view.backgroundColor = [UIColor colorWithRed:49/255.f green:182/255.f blue:254/255.f alpha:1.f]; //[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.jpeg"]];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:219/255.f green:185/255.f blue:124/255.f alpha:1.f];
    
    UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    tempButton.backgroundColor = [UIColor clearColor];
    [tempButton setTitle:@"新建" forState:0];
    [tempButton setTitleColor:[UIColor whiteColor] forState:0];
    [tempButton addTarget:self action:@selector(buildNewNoteAction) forControlEvents:UIControlEventTouchUpInside];
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    //增加可编辑按钮
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 32)];
    tempButton.backgroundColor = [UIColor clearColor];
    [tempButton setImage:[UIImage imageNamed:@"btn_menu"] forState:0];
    [tempButton addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    [self initData];
    [self initView];
}

- (void)initData {
    _dataArray = [[NSMutableArray alloc] init];
    
    //获取应用程序沙盒的Documents目录,得到完整的文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"note.plist"];
    
    //读取plist文件数据
    _dataArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSLog(@"plist data : %@", _dataArray);
    
    num = _dataArray.count;
}

- (void)initView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - 35) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.allowsSelectionDuringEditing = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    UIButton *addNoteBtn = [[UIButton alloc] initWithFrame:CGRectMake((KSCREEN_WIDTH - 30)/2, CGRectGetMaxY(self.tableView.frame) + 2.5, 30, 30)];
//    addNoteBtn.backgroundColor = [UIColor greenColor];
    [addNoteBtn setImage:[UIImage imageNamed:@"button_add"] forState:UIControlStateNormal];
    [addNoteBtn addTarget:self action:@selector(buildNewNoteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addNoteBtn];
}

#pragma mark - Action
- (void)menuAction {
    [self.revealController showViewController:self.revealController.leftViewController];
}

- (void)buildNewNoteAction {
    NSLog(@"新增笔记。。。");
    
    TakeNoteViewController *vc = [[TakeNoteViewController alloc] init];
    vc.noteType = KNOTE_NEW;
    vc.noteIndex = _dataArray.count;
    vc.note = @"";
    vc.dataSource = _dataArray;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)addNewNoteAction {
    NSLog(@"Tap the button");
    
    TakeNoteViewController *vc = [[TakeNoteViewController alloc] init];
    vc.noteType = KNOTE_NEW;
    vc.noteIndex = 0;
    vc.note = @"";
    vc.dataSource = _dataArray;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableView方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
//    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *noteDic = [_dataArray objectAtIndex:_dataArray.count-indexPath.row-1];
//    cell.contentLabel.text = [noteDic objectForKey:@"content"];
//    cell.dateLabel.text = [noteDic objectForKey:@"date"];
    
    cell.textLabel.text = [noteDic objectForKey:@"content"];
    cell.detailTextLabel.text = [noteDic objectForKey:@"date"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NoteTableViewCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.editing) //判断是否是编辑状态
    {
//        [mArr addObject:indexPath];
        NSLog(@"....");
    }
    else {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selected = NO;
        
        TakeNoteViewController *vc = [[TakeNoteViewController alloc] init];
        vc.noteType = KNOTE_EDIT;
        vc.noteIndex = _dataArray.count-indexPath.row-1;
        vc.note = [[_dataArray objectAtIndex:_dataArray.count-indexPath.row-1] objectForKey:@"content"];
        vc.dataSource = _dataArray;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark --取消选择的方法
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"2222222222222222222");
//    [mArr removeObject:indexPath];
//    NSLog(@"%@", mArr);
}

#pragma mark - 是否可删除行
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//提交删除编辑的实现方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        
        //获取应用程序沙盒的Documents目录,得到完整的文件名
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"note.plist"];
        //删除数据
        _dataArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
        [_dataArray removeObjectAtIndex:_dataArray.count-indexPath.row-1];
        //重新写入文件
        [_dataArray writeToFile:path atomically:YES];
        
//        [self.tableView reloadData];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


#pragma mark --可编辑性
//设置是否具有可编辑性的代理方法
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:YES];
    [self.tableView setEditing:editing animated:YES];
    NSLog(@"1111");
    if (!editing) //退出编辑的时候执行的操作
    {
        NSLog(@"2222");
//        if (mArr != nil) //当数组不为空的时候才移除
//        {
//            [mArr removeAllObjects];
//        }
    }
}

//设置返回编辑样式的代理方法
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}



#pragma mark - emptyState
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"emptys"];
}


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"Markdown your things";
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0], NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"This allows you to share your life and work.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0]};
    
    return [[NSAttributedString alloc] initWithString:@"Continue" attributes:attributes];
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"empty"];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

#pragma mark - Delegate Implementation
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView
{
    // Do something
    NSLog(@"Tap the button");
    
    TakeNoteViewController *vc = [[TakeNoteViewController alloc] init];
    vc.noteType = KNOTE_NEW;
    vc.noteIndex = 0;
    vc.note = @"";
    vc.dataSource = _dataArray;
    [self.navigationController pushViewController:vc animated:YES];
}






@end
