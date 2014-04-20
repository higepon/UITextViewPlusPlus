//
// Created by Taro Minowa on 4/20/14.
// Copyright (c) 2014 Higepon Taro Minowa. All rights reserved.
//

@interface UITextViewPlusPlus : UITextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer;

- (void)sizeToFitContent;

@end