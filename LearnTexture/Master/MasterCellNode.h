//
//  MasterCellNode.h
//  LearnTexture
//
//  Created by 廖超龙 on 2018/8/3.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface MasterCellNode : ASCellNode

@property (nonatomic) BOOL isHeader;
@property (nonatomic,strong) ASTextNode *textNode;

@end
