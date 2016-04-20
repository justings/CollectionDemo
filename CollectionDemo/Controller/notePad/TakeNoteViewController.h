//
//  TakeNoteViewController.h
//  CollectionDemo
//
//  Created by guowei on 15/8/7.
//  Copyright (c) 2015年 guowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface TakeNoteViewController : UIViewController

@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger noteType;
@property (nonatomic, assign) NSInteger noteIndex;

@end
