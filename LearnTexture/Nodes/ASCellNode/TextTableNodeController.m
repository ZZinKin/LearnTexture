//
//  TextTableNodeController.m
//  LearnTexture
//
//  Created by 廖超龙 on 2018/8/3.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "TextTableNodeController.h"

@interface TextTableNodeController () <ASTableDelegate, ASTableDataSource>

@property (nonatomic, copy) NSArray *texts;

@end

@implementation TextTableNodeController

- (void)dealloc {
    NSLog(@"TextTableNodeController dealloc ♻️");
}

- (instancetype)initWithTexts:(NSArray<NSString*> *)text {
    ASTableNode *tableNode = [[ASTableNode alloc] init];
    self = [super initWithNode:tableNode];
    _texts = text;
    tableNode.delegate = self;
    tableNode.dataSource = self;
    return self;
}

#pragma mark - ASTableDelegate

- (ASSizeRange)tableNode:(ASTableNode *)tableNode constrainedSizeForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ASSizeRangeMake(CGSizeMake(0, 50));
}

#pragma mark - ASTableDataSource
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return _texts.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    return ^ASCellNode * _Nonnull(void) {
        typeof(weakSelf) sself = weakSelf;
        ASTextCellNode *textCellNode = [[ASTextCellNode alloc] init];
        textCellNode.text = sself.texts[indexPath.row];
        return textCellNode;
    };
}

@end
