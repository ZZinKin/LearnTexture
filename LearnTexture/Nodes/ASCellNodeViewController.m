//
//  ASCellNodeViewController.m
//  LearnTexture
//
//  Created by 廖超龙 on 2018/8/3.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "ASCellNodeViewController.h"

@interface ASCellNodeViewController () <ASPagerDelegate, ASPagerDataSource>

@end

@implementation ASCellNodeViewController

#pragma mark - view controller life cycle
- (instancetype)init {
    ASPagerNode *pageNode = [[ASPagerNode alloc] init];
    if ([super initWithNode:pageNode]) {
        pageNode.delegate = self;
        pageNode.dataSource = self;
    }
    return self;
}

#pragma mark - ASPagerDelegate
- (BOOL)collectionNode:(ASCollectionNode *)collectionNode shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - ASPagerDataSource

/**
 * This method replaces -collectionView:numberOfItemsInSection:
 *
 * @param pagerNode The sender.
 * @return The total number of pages that can display in the pagerNode.
 */
- (NSInteger)numberOfPagesInPagerNode:(ASPagerNode *)pagerNode {
    return 3;
}

/**
 * This method replaces -collectionView:nodeForItemAtIndexPath:
 *
 * @param pagerNode The sender.
 * @param index     The index of the requested node.
 * @return a node for display at this index. This will be called on the main thread and should
 *   not implement reuse (it will be called once per row).  Unlike UICollectionView's version,
 *   this method is not called when the row is about to display.
 */
- (ASCellNode *)pagerNode:(ASPagerNode *)pagerNode nodeAtIndex:(NSInteger)index {
    return nil; //TODO: complete this
}


@end
