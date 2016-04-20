//
//  NoteTableViewCell.h
//  CollectionDemo
//
//  Created by guowei on 15/8/12.
//  Copyright (c) 2015年 guowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *dateLabel;

+ (float)cellHeight;

@end
