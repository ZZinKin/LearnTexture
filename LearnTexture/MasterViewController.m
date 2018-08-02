//
//  MasterViewController.m
//  LearnTexture
//
//  Created by cello on 2018/8/3.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController () <ASTableDelegate, ASTableDataSource>

@property (nonatomic, strong) ASTableNode *tableNode;

@end

@implementation MasterViewController

#pragma mark - view controller's life cycle

- (instancetype)init {
    _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
    self = [super initWithNode:_tableNode];
    
    if (self) {
        _tableNode.dataSource = self;
        _tableNode.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - ASTableDelegate

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select node: %@", indexPath);
    [tableNode deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 * Provides the constrained size range for measuring the row at the index path.
 * Note: the widths in the returned size range are ignored!
 *
 * @param tableNode The sender.
 *
 * @param indexPath The index path of the node.
 *
 * @return A constrained size range for layout the node at this index path.
 */
- (ASSizeRange)tableNode:(ASTableNode *)tableNode constrainedSizeForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ASSizeRangeMake(CGSizeMake(UIScreen.mainScreen.bounds.size.width, 100));
}

#pragma mark - ASTableDataSource

/**
 * Asks the data source for the number of sections in the table node.
 *
 * @see @c numberOfSectionsInTableView:
 */
- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    return 3;
}

/**
 * Asks the data source for the number of rows in the given section of the table node.
 *
 * @see @c numberOfSectionsInTableView:
 */
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return 3;
}

/**
 * Asks the data source for a block to create a node to represent the row at the given index path.
 * The block will be run by the table node concurrently in the background before the row is inserted
 * into the table view.
 *
 * @param tableNode The sender.
 * @param indexPath The index path of the row.
 *
 * @return a block that creates the node for display at this indexpath.
 *   Must be thread-safe (can be called on the main thread or a background
 *   queue) and should not implement reuse (it will be called once per row).
 *
 * @note This method takes precedence over tableNode:nodeForRowAtIndexPath: if implemented.
 */
- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ^ASCellNode * _Nonnull(void) {
        ASCellNode *cell = ASCellNode.new;
        return cell;
    };
}




@end
