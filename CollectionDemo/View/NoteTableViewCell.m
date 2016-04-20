//
//  NoteTableViewCell.m
//  CollectionDemo
//
//  Created by guowei on 15/8/12.
//  Copyright (c) 2015年 guowei. All rights reserved.
//

#import "NoteTableViewCell.h"

#define kCellHeight 60

@implementation NoteTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float cellWidht = [UIScreen mainScreen].bounds.size.width;
        
        self.frame = CGRectMake(0, 0, cellWidht, kCellHeight);
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, cellWidht - 120, kCellHeight)];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.numberOfLines = 1;
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_contentLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_contentLabel.frame) + 5, 0, 80, kCellHeight)];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_dateLabel];
        
    }
    
    
    return self;
}

+ (float)cellHeight
{
    return kCellHeight;
}

@end
