//
//  ViewController.m
//  CollectionDemo
//
//  Created by guowei on 15/4/16.
//  Copyright (c) 2015年 guowei. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "NotePadViewController.h"
#import <AFNetworking.h>

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpeg"]]; //[UIColor whiteColor];
    self.title = @"Collection";
    
    UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 32)];
    tempButton.backgroundColor = [UIColor clearColor];
    [tempButton setImage:[UIImage imageNamed:@"btn_menu"] forState:0];
    [tempButton setTitleColor:[UIColor blackColor] forState:0];
    [tempButton addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    //collectionView
    float cellWidth = self.view.frame.size.width / 3;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(cellWidth - 10, cellWidth - 10);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 50, CGRectGetWidth(self.view.frame)-20, 500) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    
}

#pragma mark - Action
- (void)menuAction {
    [self.revealController showViewController:self.revealController.leftViewController];
}


#pragma mark - UICollectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.aLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"click %ld", (long)indexPath.row);
    
    if (indexPath.row == 0) {
        //AFNetworking POST 请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 10.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        
        NSString *urlStr = @"http://jd.vsa.com.cn/phoneNavigateManage_queryToJson.shtml";
//        urlStr = @"http://121.46.2.233:9080/myJson/banners";
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"merchantName", @"JD_android_client",@"sign", @"F74591AE9B76FB18409F8811D6BCDC6A", nil];
        
        [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 请求成功，解析数据
//            NSLog(@"%@", responseObject);
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            
            NSLog(@"%@", dic);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 请求失败
            NSLog(@"%@", [error localizedDescription]);
            
        }];
    }
    else if (indexPath.row == 1) {
        //AFNetworking GET 请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        }
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSLog(@"这里打印请求成功要做的事");
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
                 NSLog(@"%@",error);  //这里打印错误信息
             }];
    }
    
    
    [self.revealController showViewController:self.revealController.frontViewController];
}


@end
