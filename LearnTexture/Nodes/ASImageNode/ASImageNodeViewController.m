//
//  ASImageNodeViewController.m
//  LearnTexture
//
//  Created by cello on 2018/8/4.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "ASImageNodeViewController.h"

static NSString *const NetworkImageURLString = @"https://avatars0.githubusercontent.com/u/30101316?s=460&v=4";

@interface ASImageNodeViewController ()

@end

@implementation ASImageNodeViewController

- (void)dealloc {
    NSLog(@"ASImageNodeViewController dealloc ♻️");
}

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
            NSLog(@"Image node load finished %fms", (endTime-startTime)*1000);
        }
    }];
    
    [self.node addSubnode:imageNode];

    ASDisplayNode *emptyNode = [ASDisplayNode new];
    [self.node addSubnode:emptyNode];
    
    ASNetworkImageNode *network = [[ASNetworkImageNode alloc] init];
    network.placeholderColor = UIColor.lightGrayColor;
    network.URL = [NSURL URLWithString:NetworkImageURLString];
    [network setNeedsDisplayWithCompletion:^(BOOL canceled) {
        if (!canceled) {
            CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
            NSLog(@"Network Image node load finished %fms", (endTime-startTime)*1000);
        }
    }];
    [self.node addSubnode:network];
    
    //layout is not allow to add or remove subnode
    // There would be a retain cycle if you use self directly
    
    __weak typeof(self) wself = self;
    self.node.layoutSpecBlock = ^ASLayoutSpec * _Nonnull(__kindof ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize) {
        if(!wself) return ASLayoutSpec.new; typeof(wself) sself = wself; //simply guard let `self` = self in Swift
        // navigationBar area is invisible,so add an empty node as padding space
        CGFloat navigationY = CGRectGetMaxY(sself.navigationController.navigationBar.frame);
        emptyNode.style.height = ASDimensionMake(navigationY);
        
        // center the image node
        ASCenterLayoutSpec *center1 = [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY sizingOptions:ASCenterLayoutSpecSizingOptionMinimumXY child:imageNode];
        
        // you can either provice the preferedSize of use the ratio spec for network image
//        ASRatioLayoutSpec *rationSpec = [ASRatioLayoutSpec ratioLayoutSpecWithRatio:1.0 child:network];
        network.style.preferredSize = CGSizeMake(100, 100);
        ASCenterLayoutSpec *center2 = [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY sizingOptions:ASCenterLayoutSpecSizingOptionMinimumXY child:network];
        
        ASStackLayoutSpec *mainStack = [ASStackLayoutSpec verticalStackLayoutSpec];
        mainStack.children = @[emptyNode, center1, center2];
        mainStack.flexWrap = YES;
        mainStack.spacing = 50;
        
        return mainStack;
    };
}

- (void)tapImageNode:(id)sender {
    NSLog(@"image node is tapped");
}
@end
