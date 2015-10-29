//
//  LZCustomLayout.h
//  WaterFlow
//
//  Created by Scott_Mr on 15/10/28.
//  Copyright © 2015年 Scott_Mr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZCustomLayout : UICollectionViewFlowLayout

/// 列数
@property (nonatomic, assign) NSInteger columCount;
/// 传递进来的模型数组
@property (nonatomic, strong) NSArray *shopsArr;

@end
