//
//  MasterCellNode.m
//  LearnTexture
//
//  Created by 廖超龙 on 2018/8/3.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "MasterCellNode.h"

@implementation MasterCellNode

- (instancetype)init {
    if (self = [super init]) {
        _textNode = [[ASTextNode alloc] init];
        [self addSubnode:_textNode];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    UIEdgeInsets insets = UIEdgeInsetsMake(10 + _isHeader*20, 30 - 15*_isHeader, 10, 18);
    ASInsetLayoutSpec *inset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets
                                                                      child:_textNode];
    
    return inset;
}

@end
