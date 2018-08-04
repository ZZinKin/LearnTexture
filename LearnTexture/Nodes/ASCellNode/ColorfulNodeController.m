//
//  ColorfulNodeController.m
//  LearnTexture
//
//  Created by 廖超龙 on 2018/8/3.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "ColorfulNodeController.h"
#import "ColorfulCellNode.h"

static const NSInteger numberOfItems = 1000;
#define RANDOM_FLOAT_VALUE ((arc4random()%1001)/1000.0)

@interface ColorfulNodeController () <ASCollectionDelegate, ASCollectionDataSource>

@property (nonatomic, strong) NSArray<UIColor *> *colors;
@property (nonatomic, strong) ASCollectionNode *collectionNode;

@end

@implementation ColorfulNodeController

- (void)dealloc {
    NSLog(@"ColorfulNodeController dealloc ♻️");
}

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    ASCollectionNode *node = [[ASCollectionNode alloc] initWithCollectionViewLayout:layout];
    self = [super initWithNode:node];
    if (self) {
        node.delegate = self;
        node.dataSource = self;
        _collectionNode = node;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *colorCollection = [NSMutableArray arrayWithCapacity:numberOfItems];
        for (NSInteger i = 0; i < numberOfItems; i++) {
            [colorCollection addObject:[UIColor colorWithRed:RANDOM_FLOAT_VALUE green:RANDOM_FLOAT_VALUE blue:RANDOM_FLOAT_VALUE alpha:1.0]];
        }
        self.colors = colorCollection.copy;
        [self.node setNeedsLayout];
    });
}

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    return numberOfItems;
}
- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    return ^ASCellNode * _Nonnull(void) {
        typeof(weakSelf) sself = weakSelf;
        ColorfulCellNode *node = [[ColorfulCellNode alloc] init];
        node.color = sself.colors[indexPath.row];
        return node;
    };
}

@end
