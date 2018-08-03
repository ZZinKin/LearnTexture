//
//  TopNavigationNode.m
//  LearnTexture
//
//  Created by 廖超龙 on 2018/8/3.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "TopNavigationNode.h"

@interface TopNavigationNode() <ASCollectionDataSource>

@property (nonatomic, strong) NSArray<NSString*> *items;

@end

@implementation TopNavigationNode

- (instancetype)initWithItems:(NSArray<NSString*> *)items {
    UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    if (self = [super initWithCollectionViewLayout:layout]) {
        _items = items.copy;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - ASCollectionDataSource
- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    return _items.count;
}

- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    return ^ASCellNode *_Nonnull (void) {
        typeof(weakSelf) sself = weakSelf;
        ASTextCellNode *cell = [[ASTextCellNode alloc] init];
        cell.text = sself.items[indexPath.row];
        cell.textAttributes = @{NSForegroundColorAttributeName: UIColor.blueColor, NSFontAttributeName: [UIFont systemFontOfSize:15]};
        return cell;
    };
}

@end
