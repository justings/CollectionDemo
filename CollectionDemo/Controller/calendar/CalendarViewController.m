//
//  CalendarViewController.m
//  CollectionDemo
//
//  Created by guowei on 15/9/9.
//  Copyright (c) 2015年 guowei. All rights reserved.
//

#import "CalendarViewController.h"
#import "NSDate+FSExtension.h"
#import "FSCalendarAppearance.h"
#import "SSLunarDate.h"
#import "CalendarConfigViewController.h"

#define kPink [UIColor colorWithRed:198/255.0 green:51/255.0 blue:42/255.0 alpha:1.0]
#define kBlue [UIColor colorWithRed:31/255.0 green:119/255.0 blue:219/255.0 alpha:1.0]
#define kBlueText [UIColor colorWithRed:14/255.0 green:69/255.0 blue:221/255.0 alpha:1.0]

@interface CalendarViewController ()

@property (nonatomic, strong) FSCalendar *calendar;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"日历";
    
    UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 32)];
    tempButton.backgroundColor = [UIColor clearColor];
    [tempButton setImage:[UIImage imageNamed:@"btn_menu"] forState:0];
    [tempButton setTitleColor:[UIColor blackColor] forState:0];
    [tempButton addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _subtitle = YES;
    _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, 320, 350)];
    [self.view addSubview:_calendar];
}

#pragma mark - Action
- (void)menuAction {
    [self.revealController showViewController:self.revealController.leftViewController];
}


#pragma mark --

- (NSString *)calendar:(FSCalendar *)calendarView subtitleForDate:(NSDate *)date
{
    return _subtitle ? [[SSLunarDate alloc] initWithDate:date].dayString : nil;
}

- (BOOL)calendar:(FSCalendar *)calendarView hasEventForDate:(NSDate *)date
{
    return date.fs_day == 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[CalendarConfigViewController class]]) {
        [segue.destinationViewController setValue:self forKey:@"viewController"];
    }
}

- (void)setTheme:(NSInteger)theme
{
//    if (_theme != theme) {
//        _theme = theme;
//        switch (theme) {
//            case 0:
//            {
//                [[FSCalendar appearance] setWeekdayTextColor:kBlueText];
//                [[FSCalendar appearance] setHeaderTitleColor:kBlueText];
//                [[FSCalendar appearance] setEventColor:[UIColor cyanColor]];
//                [[FSCalendar appearance] setSelectionColor:kBlue];
//                [[FSCalendar appearance] setHeaderDateFormat:@"yyyy-M"];
//                [[FSCalendar appearance] setMinDissolvedAlpha:0.2];
//                [[FSCalendar appearance] setTodayColor:kPink];
//                [[FSCalendar appearance] setUnitStyle:FSCalendarUnitStyleCircle];
//                break;
//            }
//            case 1:
//            {
//                [[FSCalendar appearance] setWeekdayTextColor:[UIColor redColor]];
//                [[FSCalendar appearance] setHeaderTitleColor:[UIColor darkGrayColor]];
//                [[FSCalendar appearance] setEventColor:[UIColor greenColor]];
//                [[FSCalendar appearance] setSelectionColor:[UIColor blueColor]];
//                [[FSCalendar appearance] setHeaderDateFormat:@"yyyy-MM"];
//                [[FSCalendar appearance] setMinDissolvedAlpha:0.5];
//                [[FSCalendar appearance] setTodayColor:[UIColor redColor]];
//                [[FSCalendar appearance] setUnitStyle:FSCalendarUnitStyleCircle];
//                break;
//            }
//            case 2:
//            {
//                [[FSCalendar appearance] setWeekdayTextColor:[UIColor redColor]];
//                [[FSCalendar appearance] setHeaderTitleColor:[UIColor redColor]];
//                [[FSCalendar appearance] setEventColor:[UIColor greenColor]];
//                [[FSCalendar appearance] setSelectionColor:[UIColor blueColor]];
//                [[FSCalendar appearance] setHeaderDateFormat:@"yyyy/MM"];
//                [[FSCalendar appearance] setMinDissolvedAlpha:1.0];
//                [[FSCalendar appearance] setUnitStyle:FSCalendarUnitStyleRectangle];
//                [[FSCalendar appearance] setTodayColor:[UIColor orangeColor]];
//                break;
//            }
//            default:
//                break;
//        }
//        
//    }
}

- (void)setSubtitle:(BOOL)subtitle
{
    if (_subtitle != subtitle) {
        _subtitle = subtitle;
        [_calendar reloadData];
    }
}

@end
