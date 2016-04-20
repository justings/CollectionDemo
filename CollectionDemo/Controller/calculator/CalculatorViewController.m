//
//  CalculatorViewController.m
//  Calculator
//
//  Created by SevenJustin on 13-10-17.
//  Copyright (c) 2013年 GuoWei. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //导航栏
    self.title = @"计算器";
    
    //设置view的背景图片-方法1（图片按原图大小显示）
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"robot.jpg"]];
    
    //设置view的背景图片-方法2（图片可以自动适应屏幕大小）
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.jpeg"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:imgView atIndex:0];
    
    //目录
    UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 32)];
    tempButton.backgroundColor = [UIColor clearColor];
    [tempButton setImage:[UIImage imageNamed:@"btn_menu"] forState:0];
    [tempButton setTitleColor:[UIColor blackColor] forState:0];
    [tempButton addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //创建UILabel
    label = [[UILabel alloc] initWithFrame:CGRectMake(10, 64 + 18, 300, 40)];
    label.text = @""; //label显示的文字
    label.textColor = [UIColor whiteColor]; //text的颜色
    label.textAlignment = NSTextAlignmentRight; //text的对齐方式
    label.backgroundColor = [UIColor colorWithRed:42/255.f green:104/255.f blue:217/255.f alpha:1.f]; //[UIColor colorWithPatternImage:[UIImage imageNamed:@"lb"]];
    label.font = [UIFont fontWithName:@"AmericanTypewriter-Condensed" size:22]; //text的字体
    label.adjustsFontSizeToFitWidth = NO;//设置text字体是否要减小来适应label的区域，只有行数是1时有效
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 5;
    label.layer.borderWidth = 1;
    label.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:label]; //把label对象添加到view上
    //[label release]; //释放内存（**在这里释放的时候label不会消失，因为当把label对象添加到view上的时候父视图已经对引用计数加1了。）
    

    
    //成员变量初始化
    num1 = 0;
    num2 = 0;
    str = [[NSMutableString alloc] init];  //成员变量可以进行初始化或者retain或copy来开辟内存，然后在dealloc里面释放
    lastOp = 0;
    currentOp = 0;
    result = [[NSMutableString alloc] init];
    rootController = [[CalculatorViewController alloc] initWithNibName:@"CalculatorViewController" bundle:nil];
    
    int x = 10;
    int y = 200;
    NSArray *array = [NSArray arrayWithObjects:@"!", @"^", @"sin", @"cos", @"tan", nil];
    for (int i=0; i<5; i++)
    {
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"head"]];
//        button.backgroundColor = [UIColor blackColor];
        button.frame = CGRectMake(x, y, 52, 52);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(calButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+200;
//        [self.view addSubview:button];
        x = x+62;
    }
    
    x = 10; y = 162;
    //循环创建10个数字按钮
    for (int i=0; i<10; i++)
    {
        NSString *s = [[NSNumber numberWithInt:(i+1)%10] stringValue];
//        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button = [[UIButton alloc] init];
        button.frame = CGRectMake(x, y, 52, 52);
        [button setTitle:s forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:20.f];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = (i+1)%10;
//        button.backgroundColor = [UIColor whiteColor];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:0];
        button.layer.cornerRadius = 52/2;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor colorWithRed:42/255.f green:104/255.f blue:217/255.f alpha:1.f].CGColor;
        [self.view addSubview:button];
        if (x>72)
        {
            y = y + 82;
            x = 10;
        }
        else
        {
            x = x + 62;
        }
    }
    
    //"+"号按钮
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//  button=[UIButton buttonWithType:UIButtonTypeCustom]; //使用UIButtonTypeCustom,可以改变button的颜色
    button.frame = CGRectMake(196, 162, 52, 52); //设置按钮位置
    [button setTitle:@"+" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20.f];
//  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title颜色
    [button addTarget:self action:@selector(calButton:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 100;
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:42/255.f green:104/255.f blue:217/255.f alpha:1.f].CGColor;
    [self.view addSubview:button];
    
    //"-"号按钮
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(258, 162, 52, 52);
    [button setTitle:@"-" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20.f];
    [button addTarget:self action:@selector(calButton:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 101;
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:42/255.f green:104/255.f blue:217/255.f alpha:1.f].CGColor;
    [self.view addSubview:button];
    
    //"*"号按钮
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(196, 244, 52, 52);
    [button setTitle:@"*" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20.f];
    [button addTarget:self action:@selector(calButton:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 102;
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:42/255.f green:104/255.f blue:217/255.f alpha:1.f].CGColor;
    [self.view addSubview:button];
    
    //"/"号按钮
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(258, 244, 52, 52);
    [button setTitle:@"/" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20.f];
    [button addTarget:self action:@selector(calButton:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 103;
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:42/255.f green:104/255.f blue:217/255.f alpha:1.f].CGColor;
    [self.view addSubview:button];
    
    //"back"号按钮
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(196, 326, 52, 52);
    [button setTitle:@"DEL" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20.f];
    [button addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:42/255.f green:104/255.f blue:217/255.f alpha:1.f].CGColor;
    [self.view addSubview:button];
    
    //"C"号按钮
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(258, 326, 52, 52);
    [button setTitle:@"C" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20.f];
    [button addTarget:self action:@selector(clearButton:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:42/255.f green:104/255.f blue:217/255.f alpha:1.f].CGColor;
    [self.view addSubview:button];
    
    //"."号按钮
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(72, 408, 114, 52);
    [button setTitle:@"." forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20.f];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:42/255.f green:104/255.f blue:217/255.f alpha:1.f].CGColor;
    [self.view addSubview:button];
    
    //"="号按钮
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(196, 408, 114, 52);
    [button setTitle:@"=" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20.f];
    [button addTarget:self action:@selector(calButton:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:42/255.f green:104/255.f blue:217/255.f alpha:1.f].CGColor;
    [self.view addSubview:button];
    
}

#pragma mark - Action
- (void)menuAction {
    [self.revealController showViewController:self.revealController.leftViewController];
}

int new = 0;//这个标识的作用:当点击了等号后，再次执行的是第二次运算

//输入0-9、‘.’
-(void) clickButton:(UIButton *)sender
{
    if ([label.text isEqualToString:@""])
    {
        if ([sender.currentTitle isEqualToString:@"."])
        {
            return;
        }
    }
    
    //控制第一次输入'0'的个数; 处理第一次输入的是'0',接着输入数字
    if ([label.text isEqualToString:@"0"])
    {
        if ([sender.currentTitle isEqualToString:@"0"])
        {
            [str setString:@""];
        }
    }
    
    //防止重复输入'.'
    NSUInteger length = [label.text length]; //获取label上的内容
    if (length > 0) {
        NSRange range = {length-1, 1};
        NSString *tempStr = [label.text substringWithRange:range];
        
        if ([tempStr isEqualToString:@"."]) {
            if ([sender.currentTitle isEqualToString:@"."])
            {
                return;
            }
        }
    }
    
    
    //这个判断的作用:当点击了等号后，再次执行的是第二次运算
    if (new == 1)
    {
        [str setString:@""];  //把str设为空
        if ([sender.currentTitle isEqualToString:@"."]) {
            [str setString:@"0"];
        }
        label.text = str;
        new = 0;
    }
    
    [str appendString:sender.currentTitle]; //用num2来保存最新输入的数字
    label.text = str;
    num2 = [str floatValue];
    NSLog(@"num2 = %g", num2);
    
}
//输入其它按钮
-(void) calButton:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"="])
    {
        new = 1;
        [self calFun:currentOp];
        label.text = result; //输出结果
        [str setString:result];  //用str把结果保存起来
        currentOp = 0;
        lastOp = 0;
    }
    else
    {
        if ([label.text isEqualToString:@""])
        {
            return;
        }
        
        lastOp = currentOp;
        [self calFun:lastOp];
        currentOp = sender.tag;
        NSLog(@"currentOp = %ld", (long)currentOp);
        if (lastOp != 0)
        {
            [str setString:result];  //用str把结果保存起来
        }
        [str appendString:sender.currentTitle]; //拼接上输入的按钮符号
        label.text = str; //输出结果
        num1 = [label.text floatValue]; //用num1来保存运算符前面的数
        NSLog(@"num1 = %g", num1);
        [str setString:@""]; //设置str为空
        
    }
}

//进行运算
-(void) calFun:(NSInteger)tag
{
    if (tag == 100) //进行加法运算
    {
        NSLog(@"num1 = %f, num2 = %f", num1, num2);
        result = [NSString stringWithFormat:@"%g", num1+num2];
    }
    if (tag == 101) //进行减法运算
    {
        result = [NSString stringWithFormat:@"%g", num1-num2];
    }
    if (tag == 102) //进行乘法运算
    {
        NSLog(@"乘法");
        result = [NSString stringWithFormat:@"%g", num1*num2];
    }
    if (tag == 103) //进行除法运算
    {
        if (num2 == 0)
        {
            NSMutableString *str1 = [NSMutableString stringWithString:@"错误提示：被除数不能为0"];
            result = str1;
        }
        else
            result = [NSString stringWithFormat:@"%g", num1/num2];
    }
    if (tag == 200) //进行阶乘运算
    {
        double s = 1;
        for (int i=num1; i>0; i--)
        {
            s = s * i;
        }
        if (num2 != 0) //判断'!'符号后是否有数字，如果有则相乘
        {
            s = s * num2;
        }
        result = [NSString stringWithFormat:@"%g", s];
    }
    if (tag == 201) //进行^运算
    {
        result = [NSString stringWithFormat:@"%g", pow(num1, num2)];
    }
    if (tag == 202) //进行sin运算
    {
        double s = sin(num2);
        if (num1 != 0)  //判断运算符号前是否有数字，例如：（3sin10）如果有则相乘
        {
            s = num1 * s;
        }
        result = [NSString stringWithFormat:@"%g", s];
    }
    if (tag == 203) //进行cos运算
    {
        double s = cos(num2);
        if (num1 != 0)
        {
            s = num1 * s;
        }
        result = [NSString stringWithFormat:@"%g", s];
    }
    if (tag == 204) //进行tan运算
    {
        double s = tan(num2);
        if (num1 != 0)
        {
            s = num1 * s;
        }
        result = [NSString stringWithFormat:@"%g", s];
    }
    if (tag == 0) //什么运算都不执行时，把当前的值赋给result
    {
        result = [NSString stringWithFormat:@"%g", num2];
    }
}

//退格键
-(void) backButton:(UIButton *)sender
{
    NSUInteger length = [label.text length]; //获取label上的内容
    if (length < 1) {
        return;
    }
    NSRange range = {length-1, 1};
    [str deleteCharactersInRange:range]; //删除label的最后一个字符
    label.text = str; //再在label上显示出来
}

//清除键
-(void)clearButton:(UIButton *)sender
{
    [str setString:@""];  //把str设为空
    label.text = @"";
    num1 = 0;
    num2 = 0;
    lastOp = 0;
    currentOp = 0;
}



@end








