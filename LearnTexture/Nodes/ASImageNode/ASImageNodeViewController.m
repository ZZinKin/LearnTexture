//
//  ASImageNodeViewController.m
//  LearnTexture
//
//  Created by cello on 2018/8/4.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "ASImageNodeViewController.h"

@interface ASImageNodeViewController ()

@end

@implementation ASImageNodeViewController

- (instancetype)init {
    ASDisplayNode *node = [ASDisplayNode new];
    node.backgroundColor = [UIColor whiteColor];
    self = [super initWithNode:node];
    if (self) {
        [self setupSubnodesAfterInit];
    }
    return self;
}

- (void)setupSubnodesAfterInit {
    ASImageNode *imageNode = [[ASImageNode alloc] init];
    
    imageNode.image = [UIImage imageNamed:@"demo_icon"];
    imageNode.contentMode = UIViewContentModeScaleAspectFill;
    imageNode.placeholderColor = UIColor.lightGrayColor;
    
    // you can add target-action to a imageNode
    [imageNode addTarget:self action:@selector(tapImageNode:) forControlEvents:ASControlNodeEventTouchUpInside];
    
    CFTimeInterval startTime = CFAbsoluteTimeGetCurrent();
    [imageNode setNeedsDisplayWithCompletion:^(BOOL canceled) {
        if (!canceled) {
            CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
            NSLog(@"Load finished %fms", (endTime-startTime)*1000);
        }
    }];
    
    [self.node addSubnode:imageNode];

    ASDisplayNode *emptyNode = [ASDisplayNode new];
    [self.node addSubnode:emptyNode];
    
    //layout is not allow to add or remove subnode
    self.node.layoutSpecBlock = ^ASLayoutSpec * _Nonnull(__kindof ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize) {
    
        // navigationBar area is invisible,so add an empty node as padding space
        CGFloat navigationY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        emptyNode.style.height = ASDimensionMake(navigationY);
        
        // center the image node
        ASCenterLayoutSpec *center = [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY sizingOptions:ASCenterLayoutSpecSizingOptionMinimumXY child:imageNode];
        
        ASStackLayoutSpec *mainStack = [ASStackLayoutSpec verticalStackLayoutSpec];
        mainStack.children = @[emptyNode, center];
        mainStack.flexWrap = YES;
        mainStack.spacing = 50;
//        imageNode.style.preferredSize = CGSizeMake(200, 200);
        
        return mainStack;
    };
}

- (void)tapImageNode:(id)sender {
    NSLog(@"image node is tapped");
}
@end
