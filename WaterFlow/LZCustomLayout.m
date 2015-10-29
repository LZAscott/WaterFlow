//
//  LZCustomLayout.m
//  WaterFlow
//
//  Created by Scott_Mr on 15/10/28.
//  Copyright © 2015年 Scott_Mr. All rights reserved.
//

#import "LZCustomLayout.h"
#import "ShopModel.h"

@interface LZCustomLayout ()

@property (nonatomic, strong) NSMutableArray *arr;

/// 记录最高一列的高度(用于最后确定collectionView的高度)
@property (nonatomic, assign) CGFloat    maxH;

@end

@implementation LZCustomLayout

#pragma 懒加载
- (NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [[NSMutableArray alloc] init];
    }
    return _arr;
}

// 当collectionView修改布局的时候会掉用此方法
// 一般在这个方法里面,设置准备工作, 如itemSize、滚动方向、内边距，如果不设置,则默认是sb中设置的数值
- (void)prepareLayout
{
    [super prepareLayout];
    
    //内容的宽度
    CGFloat contentW = self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columCount - 1) * self.minimumInteritemSpacing;
    //item的宽度
    CGFloat itemW = contentW / self.columCount;
    
    CGFloat itemH = 0;
    
    //定义C语言数组用于存储每一列的高度
    CGFloat colHeight[self.columCount];
    
    // 记录每一列的第一个元素高度
    for (int j = 0; j < self.columCount; j ++) {
        colHeight[j] = self.sectionInset.top;
    }
    
    
    // 遍历数组
    for (int i = 0; i < self.shopsArr.count; i ++) {
        
        ShopModel *shop = self.shopsArr[i];
        // item的高度  按钮比例去算
        itemH = [shop.h floatValue] / [shop.w floatValue]  * itemW;
        
        
        // 创建 UICollectionViewLayoutAttributes对象  保存每个item的frame
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes  layoutAttributesForCellWithIndexPath:indexPath];
        
        
        // 获取行高最短的一列,保证添加一个item的时候,添加在最短的那一列上面,temp记录最短的那一列的y值
        CGFloat temp = colHeight[0];

        // 记录最短的一列所在的列数索引(从0开始)
        int min = 0;
        
        for (int j = 1; j < self.columCount; j++) {
            if (temp >colHeight[j]) {
                
                temp = colHeight[j];
                
                min = j;
            }
        }
        
        
        //特别注意  放在哪个位置  也就是第几列 和 X,Y 值都有联系
        CGFloat itemX = self.sectionInset.left + min * (self.minimumInteritemSpacing   + itemW);
        attributes.frame = CGRectMake(itemX, temp, itemW, itemH);
        
        colHeight[min] = temp + itemH  + self.minimumLineSpacing;
        
        [self.arr addObject:attributes];
        
    }
    
    // 判断哪一列最高
    CGFloat maxHeight = 0;
    
    for ( int j = 0; j <self.columCount; j ++) {
        if (maxHeight < colHeight[j]) {
            maxHeight = colHeight[j];
        }
    }
    
    self.maxH = maxHeight;
}

//返回一个数组  数组里面盛放的是  UICollectionViewLayoutAttributes 对象  布局属性
//UICollectionViewLayoutAttributes  里面的frame 正好对应item的frame
//是根据 itemSize 自动算出来的 如果想改变每个的位置,提前计算出来,并且创建 布局属性保存
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.arr;
}

- (CGSize)collectionViewContentSize
{
    CGSize size = self.collectionView.bounds.size;
    size.height = self.maxH;
    
    return size;
}

@end
