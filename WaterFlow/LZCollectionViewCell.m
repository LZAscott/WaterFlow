//
//  LZCollectionViewCell.m
//  WaterFlow
//
//  Created by Scott_Mr on 15/10/28.
//  Copyright © 2015年 Scott_Mr. All rights reserved.
//

#import "LZCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "ShopModel.h"

@interface LZCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imv;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation LZCollectionViewCell

- (void)setModel:(ShopModel *)model
{
    _model = model;
    
    [_imv sd_setImageWithURL:[NSURL URLWithString:_model.img]];
    _titleLabel.text = [NSString stringWithFormat:@"价格:%@",_model.price];
    _titleLabel.textColor = [UIColor redColor];
}

@end
