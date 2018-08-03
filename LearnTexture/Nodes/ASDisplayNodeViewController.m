//
//  ASDisplayNodeViewController.m
//  LearnTexture
//
//  Created by 廖超龙 on 2018/8/3.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "ASDisplayNodeViewController.h"

@interface ASDisplayNodeViewController ()

@property (nonatomic, strong) ASDisplayNode *switchNode;

@end

@implementation ASDisplayNodeViewController

- (instancetype)init {
    ASDisplayNode *node = [[ASDisplayNode alloc] init];
    if (self = [super initWithNode:node]) {
        self.node.backgroundColor = [UIColor whiteColor];
        
        // Wrap a UIKit component
        ASDisplayNode *switchNode = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
            UISwitch *uiSwitch = [[UISwitch alloc] init];
            return uiSwitch;
        }];
        switchNode.backgroundColor = [UIColor clearColor];
        // explicitly set the position
        switchNode.position = CGPointMake(100, 100);
        [self.node addSubnode:switchNode];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ASDisplayNode";
}



@end
