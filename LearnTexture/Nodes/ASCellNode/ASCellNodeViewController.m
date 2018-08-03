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
#import "TopNavigationNode.h"

static NSArray *textsExample;

@interface ASCellNodeViewController () <ASPagerDelegate, ASPagerDataSource, ASCollectionDelegate>

@property (nonatomic, strong) ASPagerNode *pageNode;
@property (nonatomic, strong) TopNavigationNode *navigation;
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
        
        // pageNode
        ASPagerNode *pageNode = [[ASPagerNode alloc] init];
        pageNode.delegate = self;
        pageNode.dataSource = self;
        _pageNode = pageNode;
        [node addSubnode:pageNode];
        
        // top navigations
        TopNavigationNode *navigation = [[TopNavigationNode alloc] initWithItems:@[@"Text", @"Color"]];
        [node addSubnode:navigation];
        navigation.delegate = self;
        _navigation = navigation;
        
        ASDisplayNode *lineNode = [[ASDisplayNode alloc] init];
        lineNode.backgroundColor = [UIColor lightGrayColor];
        [self.node addSubnode:lineNode];
        
        __weak typeof(self) weakSelf = self;
        node.layoutSpecBlock = ^ASLayoutSpec * _Nonnull(__kindof ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize) {
            typeof(weakSelf) sself = weakSelf;
            navigation.style.preferredSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 50);
            lineNode.style.height = ASDimensionMake(1);
            lineNode.style.width = ASDimensionMake(constrainedSize.max.width);
            ASStackLayoutSpec *mainStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStart children:@[navigation, lineNode, pageNode]];
            ASInsetLayoutSpec *inset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(CGRectGetMaxY(sself.navigationController.navigationBar.frame), 0, 0, 0) child:mainStack];
            pageNode.style.flexGrow = 1.0; 
            return inset;
        };
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textsExample =  @[@"Hello, world", @"hello", @"world",@"simple",@"naive"];
    });
    return self;
}

#pragma mark - ASCollectionDelegate

- (void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionNode == _navigation) {
        NSLog(@"Tap at item %@", @(indexPath.row));
        if (indexPath.row != self.pageNode.currentPageIndex) {
            [self.pageNode scrollToPageAtIndex:indexPath.row animated:YES];
        }
    }
}


#pragma mark - ASPagerDelegate
- (BOOL)collectionNode:(ASCollectionNode *)collectionNode shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionNode != _pageNode) {
        return YES;
    }
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
