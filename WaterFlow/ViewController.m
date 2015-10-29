//
//  ViewController.m
//  WaterFlow
//
//  Created by Scott_Mr on 15/10/28.
//  Copyright © 2015年 Scott_Mr. All rights reserved.
//

#import "ViewController.h"
#import "LZCustomLayout.h"
#import "ShopModel.h"
#import "MJExtension.h"
#import "LZCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet LZCustomLayout *Layout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/// 装模型的数组
@property (nonatomic, strong) NSArray *shops;

@end

@implementation ViewController

/// 懒加载
- (NSArray *)shops
{
    if (_shops == nil) {
        _shops = [[NSMutableArray alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil];
        
        /// plist转模型数组
        _shops = [ShopModel objectArrayWithFile:path];
    }
    
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置数据，从里面拿到宽高
    self.Layout.shopsArr = self.shops;
    
    // 设置列数
    self.Layout.columCount = 3;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LZCell" forIndexPath:indexPath];
    cell.model = [self.shops objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
