//
//  ASCellNodeViewController.m
//  LearnTexture
//
//  Created by 廖超龙 on 2018/8/3.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "ASCellNodeViewController.h"
#import "TextTableNodeController.h"
#import "ColorfulNodeController.h"

static NSArray *textsExample;

@interface ASCellNodeViewController () <ASPagerDelegate, ASPagerDataSource>

@end

@implementation ASCellNodeViewController

#pragma mark - view controller life cycle

- (void)dealloc {
    NSLog(@"ASCellNodeViewController dealloc ♻️");
}

- (instancetype)init {
    ASDisplayNode *node = [[ASDisplayNode alloc] init];
    node.backgroundColor = [UIColor whiteColor];
    if (self = [super initWithNode:node]) {
        ASPagerNode *pageNode = [[ASPagerNode alloc] init];
        pageNode.delegate = self;
        pageNode.dataSource = self;
        [node addSubnode:pageNode];
        __weak typeof(self) weakSelf = self;
        node.layoutSpecBlock = ^ASLayoutSpec * _Nonnull(__kindof ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize) {
            typeof(self) sself = weakSelf;
            return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(CGRectGetMaxY(sself.navigationController.navigationBar.frame), 0, 0, 0) child:pageNode];
        };
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textsExample =  @[@"Hello, world", @"hello", @"world",@"simple",@"naive"];
    });
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
    return 2;
}


- (ASCellNodeBlock)pagerNode:(ASPagerNode *)pagerNode nodeBlockAtIndex:(NSInteger)index {
    return ^ASCellNode * _Nonnull(void) {
        if (index == 0) {
            ASCellNode *node = [[ASCellNode alloc] initWithViewControllerBlock:^UIViewController * _Nonnull{
                return [[TextTableNodeController alloc] initWithTexts:textsExample];
            } didLoadBlock:nil];
            return node;
        } else {
            ASCellNode *node = [[ASCellNode alloc] initWithViewControllerBlock:^UIViewController * _Nonnull{
                return [[ColorfulNodeController alloc] init];
            } didLoadBlock:nil];
            return node;
        }
    };
}


@end
