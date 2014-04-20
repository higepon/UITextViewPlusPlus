//
// Created by Taro Minowa on 4/20/14.
// Copyright (c) 2014 Higepon Taro Minowa. All rights reserved.
//

#import "UITextViewPlusPlus.h"


@implementation UITextViewPlusPlus {

}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        // top, left, bottom, right
        self.textContainerInset = UIEdgeInsetsMake(0, 10, 0, 10);
        self.layer.cornerRadius = 3.0f;
        self.clipsToBounds = YES;
    }
    return self;
}
@end