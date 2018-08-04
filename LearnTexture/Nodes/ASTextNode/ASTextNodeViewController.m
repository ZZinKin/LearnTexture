//
//  ASTextNodeViewController.m
//  LearnTexture
//
//  Created by cello on 2018/8/4.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "ASTextNodeViewController.h"

@interface ASTextNodeViewController () <ASTextNodeDelegate>

@property (nonatomic, strong) ASTextNode *textNode;

@end

@implementation ASTextNodeViewController

- (void)dealloc {
    NSLog(@"ASTextNodeViewController dealloc ♻️");
}

- (instancetype)init {
    self = [super initWithNode:[ASDisplayNode new]];
    if (self) {
        self.node.backgroundColor = UIColor.whiteColor;
        _textNode = [ASTextNode new];
        
        // Adding link attribute
        _textNode.linkAttributeNames = @[ NSLinkAttributeName ];
        
        NSString *blurb = @"kittens courtesy placekitten.com \U0001F638";
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:blurb];
        [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f] range:NSMakeRange(0, blurb.length)];
        [string addAttributes:@{
                                NSLinkAttributeName: [NSURL URLWithString:@"http://placekitten.com/"],
                                NSForegroundColorAttributeName: [UIColor grayColor],
                                NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle | NSUnderlinePatternDot),
                                }
                        range:[blurb rangeOfString:@"placekitten.com"]];
        _textNode.attributedText = string;
        [self.node addSubnode:_textNode];
        
        _textNode.frame = CGRectMake(100, 100, 300, 30);
        _textNode.delegate = self;
        
        [_textNode addTarget:self action:@selector(tapTextNode:) forControlEvents:ASControlNodeEventTouchUpInside];
    }
    return self;
}

- (void)tapTextNode:(id)sender {
    NSLog(@"Text node is tapped");
}

- (void)textNode:(ASTextNode *)richTextNode tappedLinkAttribute:(NSString *)attribute value:(NSURL *)URL atPoint:(CGPoint)point textRange:(NSRange)textRange {
    // the link was tapped, open it
    [[UIApplication sharedApplication] openURL:URL];
}

@end
