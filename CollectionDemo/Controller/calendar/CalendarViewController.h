//
//  CalendarViewController.h
//  CollectionDemo
//
//  Created by guowei on 15/9/9.
//  Copyright (c) 2015年 guowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"

@interface CalendarViewController : UIViewController<UIScrollViewDelegate, FSCalendarDataSource, FSCalendarDelegate>

@property (assign, nonatomic) NSInteger theme;
@property (assign, nonatomic) BOOL subtitle;

@end
