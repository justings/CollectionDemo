//
//  TakeNoteViewController.m
//  CollectionDemo
//
//  Created by guowei on 15/8/7.
//  Copyright (c) 2015年 guowei. All rights reserved.
//

#import "TakeNoteViewController.h"

@interface TakeNoteViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *myTextView;

@end

@implementation TakeNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"日记";
    self.view.backgroundColor = [UIColor colorWithRed:49/255.f green:182/255.f blue:254/255.f alpha:1.f];
    
    UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    tempButton.backgroundColor = [UIColor clearColor];
    [tempButton setTitle:@"完成" forState:0];
    [tempButton setTitleColor:[UIColor whiteColor] forState:0];
    [tempButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 32)];
    tempButton.backgroundColor = [UIColor clearColor];
    [tempButton setImage:[UIImage imageNamed:@"btn_back"] forState:0];
    [tempButton addTarget:self action:@selector(onBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self initView];
    
}

- (void)initView {
    _myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 70, 320, 250) textContainer:nil];
    _myTextView.backgroundColor = [UIColor whiteColor];
    _myTextView.text = self.note;
    _myTextView.textColor = [UIColor blackColor];
    _myTextView.font = [UIFont systemFontOfSize:18.f];
    _myTextView.layer.cornerRadius = 5;
    _myTextView.layer.borderWidth = 0;
    _myTextView.layer.borderColor = [UIColor blackColor].CGColor;
    //_myTextView.returnKeyType = UIReturnKeyNext;
    _myTextView.delegate = self;
    [self.view addSubview:_myTextView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

/**
 *
 *
 */

#pragma mark - Action
- (void)onBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveAction {
    [_myTextView resignFirstResponder];
    
    //获取应用程序沙盒的Documents目录,得到完整的文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"note.plist"];
    
    if (self.noteType == KNOTE_NEW) {
        if ([_myTextView.text isEqualToString:@""]) {
            return;
        }
        NSLog(@"dataSource : %@", self.dataSource);
        
        if (!self.dataSource) {
            self.dataSource = [[NSMutableArray alloc] init];
        }
        
        //获取当前时间
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        NSString *dataStr = [dateFormatter stringFromDate:date];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_myTextView.text, @"content", dataStr, @"date", nil];
//        [self.dataSource addObject:dic];
        [self.dataSource insertObject:dic atIndex:self.noteIndex];
        
        //把数据写进文件
        if ([self.dataSource writeToFile:path atomically:YES]) {
            NSLog(@"保存文件成功！");
        }else{
            NSLog(@"保存文件失败！");
        }
        
        self.noteType = KNOTE_EDIT;
        self.noteIndex = self.dataSource.count - 1;
    }
    else if (self.noteType == KNOTE_EDIT) {
        
        //获取当前时间
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        NSString *dataStr = [dateFormatter stringFromDate:date];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_myTextView.text, @"content", dataStr, @"date", nil];
        
        if (self.dataSource.count == 0) {
            [self.dataSource addObject:dic];
        }
        else {
            [self.dataSource replaceObjectAtIndex:self.noteIndex withObject:dic];
        }
        [self.dataSource writeToFile:path atomically:YES];
        
    }
}


#pragma mark - textView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
//    [self slideFrame:YES andTextView:textView];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
//    [self slideFrame:NO andTextView:textView];
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
//        //在这里做你响应return键的代码
//        [textView resignFirstResponder];
//        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
//    }
//    
//    return YES;
//}

- (void)slideFrame:(BOOL)up andTextView:(UITextView *)textView {
    int movementDistance = 0; // tweak as needed
    
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


#pragma mark -
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}







@end
