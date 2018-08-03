//
//  ASButtonNodeViewController.m
//  LearnTexture
//
//  Created by 廖超龙 on 2018/8/3.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "ASButtonNodeViewController.h"

@interface ASButtonNodeViewController ()

@property (nonatomic, strong) ASButtonNode *button;

@end

@implementation ASButtonNodeViewController

- (instancetype)init {
    ASDisplayNode *node = [ASDisplayNode new];
    node.backgroundColor = [UIColor whiteColor];
    self = [super initWithNode:node];
    if (self) {
        ASButtonNode *button = [[ASButtonNode alloc] init];
        [button setTitle:@"Tap me" withFont:[UIFont systemFontOfSize:18] withColor:[UIColor purpleColor] forState:UIControlStateNormal];
        button.cornerRadius = 8;
        button.borderColor = UIColor.blackColor.CGColor;
        button.clipsToBounds = YES;
        button.borderWidth = 1.0;
        [node addSubnode:button];
        button.laysOutHorizontally = NO;
        [button setImage:[UIImage imageNamed:@"demo_icon"] forState:UIControlStateNormal];
        button.frame = CGRectMake(100, 100, 200, 250);
        _button = button;
    }
    return self;
}

- (void)tapButton:(id)sender {
    NSLog(@"Button tapped");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_button addTarget:self action:@selector(tapButton:) forControlEvents:ASControlNodeEventTouchUpInside];
}
@end
