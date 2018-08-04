//
//  MasterViewController.m
//  LearnTexture
//
//  Created by cello on 2018/8/3.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "MasterViewController.h"
#import "MasterCellNode.h"

static NSArray *sectionTitles;
static NSArray<NSArray<NSString*>*> *classNames;


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
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sectionTitles = @[@"Nodes", @"Layouts", @"Demos"];
            classNames = @[@[@"",@"ASDisplayNode", @"ASCellNode", @"ASButtonNode", @"ASTextNode", @"ASImageNode"],
                           @[@""],
                           @[@""]
                           ];
        });
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Examples";
}

#pragma mark - ASTableDelegate

- (BOOL)tableNode:(ASTableNode *)tableNode shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row != 0; //header should not be highlighted
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // The naming convension
    NSString *classNamePrefix = classNames[indexPath.section][indexPath.row];
    NSString *className = [NSString stringWithFormat:@"%@ViewController", classNamePrefix];
    Class cls = NSClassFromString(className);
    if (cls) {
        UIViewController *viewController = [[cls alloc] init];
        viewController.title = classNamePrefix;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    [tableNode deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 * @note implement this method with a specific size constrains the cell with a fix size
 */
- (ASSizeRange)tableNode:(ASTableNode *)tableNode constrainedSizeForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ASSizeRangeUnconstrained;
}

#pragma mark - ASTableDataSource

- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    return sectionTitles.count;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return classNames[section].count;
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
        MasterCellNode *cell = MasterCellNode.new;
        cell.isHeader = indexPath.row == 0;
        if (cell.isHeader) {
            NSString *text = sectionTitles[indexPath.section];
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],
                                         NSForegroundColorAttributeName: [UIColor darkGrayColor]};
            cell.textNode.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
        } else {
            NSString *text = classNames[indexPath.section][indexPath.row];
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                         NSForegroundColorAttributeName: [UIColor blackColor]};
            cell.textNode.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
        }
        
        return cell;
    };
}




@end
