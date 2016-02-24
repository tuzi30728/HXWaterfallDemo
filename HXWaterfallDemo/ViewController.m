//
//  ViewController.m
//  HXWaterfallDemo
//
//  Created by HongXiangWen on 16/2/24.
//  Copyright © 2016年 WHX. All rights reserved.
//

#import "ViewController.h"
#import "HXWaterfallFlowlayout.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

static NSString * const reuseHeader = @"reuseHeader";
static NSString * const reuseFooter = @"reuseFooter";
static NSString * const reuseCell = @"reuseCell";

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray *pixclArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HXWaterfallFlowlayout *layout = [[HXWaterfallFlowlayout alloc] init];
    
    /*
     * 可通过代理实现个性化定制
     */
//    layout.columnCount = 2;
//    layout.headerHeight = 30;
//    layout.footerHeight = 30;
    
    _collectionView.collectionViewLayout = layout;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseCell];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooter];
    
    self.pixclArray = [NSMutableArray array];
    
    [self loadData];
}

- (void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [manager GET:@"http://www.uding.me/api/production/list?lifeStyleID=ID_HA" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject : %@",responseObject);
        NSArray *arr = responseObject[@"resultObj"];
        for (NSDictionary *dict in arr) {
            [self.pixclArray addObject:dict];
        }
        [_collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

#pragma mark -- UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pixclArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqual:UICollectionElementKindSectionHeader]){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseHeader forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor redColor];
        return headerView;
    }
    else {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseFooter forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor greenColor];
        return footerView;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.pixclArray[indexPath.row];
    return CGSizeMake([dict[@"width"] floatValue], [dict[@"height"] floatValue]);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCell forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDictionary *dict = self.pixclArray[indexPath.item];
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:cell.bounds];
    [imagev sd_setImageWithURL:[NSURL URLWithString:dict[@"productionUrl"]]];
    [cell.contentView addSubview:imagev];
    return cell;
}

#pragma mark -- HXWaterfallFlowlayoutDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout columnCountForSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else {
        return 3;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    } else {
        return 30;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    } else {
        return 20;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
