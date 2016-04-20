//
//  CalculatorViewController.h
//  Calculator
//
//  Created by SevenJustin on 13-10-17.
//  Copyright (c) 2013年 GuoWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController<UITextViewDelegate>
{
    UILabel *label;
    UIButton *button;
    double num1; //运算符前面的数
    double num2; //运算符后面的数
    NSInteger lastOp;  //标识：用来确定前一个运算符
    NSInteger currentOp; //标识：用来确定当前运算符
    NSMutableString *str;
    NSMutableString *result; //保存运算结果
    CalculatorViewController *rootController;
    
}

@end
