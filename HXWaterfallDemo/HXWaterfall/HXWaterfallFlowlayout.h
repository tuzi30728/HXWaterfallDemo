//
//  HXWaterfallFlowlayout.h
//  HXWaterfallDemo
//
//  Created by HongXiangWen on 16/2/24.
//  Copyright © 2016年 WHX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXWaterfallFlowlayoutDelegate <UICollectionViewDelegateFlowLayout>

@optional
/**
 *  设置每个section对应的列数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout columnCountForSection:(NSInteger)section;

/**
 *  设置每个section对应的header的高度
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section;

/**
 *  设置每个section对应的footer的高度
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section;

@end

@interface HXWaterfallFlowlayout : UICollectionViewFlowLayout

// 列数
@property (nonatomic, assign) NSInteger columnCount;

// header的高度
@property (nonatomic, assign) CGFloat headerHeight;

// footer的高度
@property (nonatomic, assign) CGFloat footerHeight;

@end
