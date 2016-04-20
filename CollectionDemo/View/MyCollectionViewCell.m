//
//  MyCollectionViewCell.m
//  CollectionDemo
//
//  Created by guowei on 15/4/16.
//  Copyright (c) 2015年 guowei. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _aLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height - 10)];
//        _aLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"head"]];
        _aLabel.backgroundColor = [UIColor clearColor];
        _aLabel.text = @"test";
        _aLabel.textColor = [UIColor whiteColor];
        _aLabel.textAlignment = NSTextAlignmentCenter;
        _aLabel.layer.cornerRadius = (self.frame.size.width-10)/2;
        _aLabel.layer.borderWidth = 5;
        _aLabel.layer.borderColor = [UIColor whiteColor].CGColor; //[UIColor colorWithRed:42/255.f green:104/255.f blue:217/255.f alpha:1.f].CGColor;
        [self addSubview:_aLabel];
    }
    
    return self;
}

@end
